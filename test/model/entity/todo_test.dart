import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:training_todo/model/entity/todo.dart';

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
}

File createTempDbFile() {
  return File(join(Directory.systemTemp.createTempSync().path, 'test.db'));
}
