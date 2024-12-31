import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:training_todo/model/entity/todo.dart';

import '../todo_list_manager_test.dart';

void main() {
  group("DBへの接続テスト", () {
    late File dbFile;
    late TodoDatabase db;

    setUp(() async {
      dbFile = createTempDbFile();
      db = TodoDatabase(dbFile);
    });

    tearDown(() async {
      await db.close();
      if (dbFile.existsSync()) {
        await dbFile.delete();
      }
    });
  });

  test("DBがまだ存在しない時に新しく作成されること", () async {
    var dbFile = createTempDbFile();
    expect(dbFile.existsSync(), false);
    final db = TodoDatabase(dbFile);
    await db.getTodos();
    expect(dbFile.existsSync(), true);
    await db.close();
  });

  test("すでにあるDBに接続できること ", () async {
    var dbFile = createTempDbFile();
    dbFile.createSync();
    final db = TodoDatabase(dbFile);
    await db.getTodos();
    expect(dbFile.existsSync(), true);
    await db.close();

    expect(dbFile.existsSync(), true);
    final createdDb = TodoDatabase(dbFile);
    await createdDb.getTodos();
    await createdDb.close();
  });

  group("DBのデータ操作テスト", () {
    test("挿入後にDBを閉じてもデータが残っていることの確認", () async {
      final dbFile = createTempDbFile();
      final db = TodoDatabase(dbFile);
      expect(await db.getTodos(), isEmpty);
      final insertData = generateDefaultTodos(1).first;
      await db.insertTodo(insertData);
      await db.close();

      final reOpenDb = TodoDatabase(dbFile);
      final tableData = await reOpenDb.getTodos();
      expect(tableData, hasLength(1));
      expect(tableData.first, insertData);
      await reOpenDb.close();
    });

    test("DBに複数個データを保存できることの確認", () async {
      final db = TodoDatabase(createTempDbFile());
      expect(await db.getTodos(), isEmpty);
      final insertData = generateDefaultTodos(100);
      for (final data in insertData) {
        await db.insertTodo(data);
      }
      expect(await db.getTodos(), hasLength(100));
      await db.close();
    });
  });
}

File createTempDbFile() {
  return File(join(Directory.systemTemp.createTempSync().path, 'test.db'));
}
