import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:training_todo/extension/datetime_extension.dart';
import 'package:training_todo/services/database/app_database.dart';

void main() {
  late AppDatabase todoDatabase;
  group("ToDoデータベースの基本試験", () {
    setUp(() async {
      todoDatabase = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await todoDatabase.close();
    });

    test('Todoの挿入と取得', () async {
      final currentDateTime = DateTime.now();

      var insertData = TodoCompanion.insert(
          title: "title",
          createdAt: currentDateTime,
          isComplete: false,
          deadline: Value(currentDateTime));
      await todoDatabase.insertTodo(insertData);

      final clearMilliSeconds = currentDateTime.removeSubSecond();

      final todos = await todoDatabase.getTodos();
      expect(todos, hasLength(1));
      expect(todos[0].title, insertData.title.value);
      expect(todos[0].deadline, clearMilliSeconds);
      expect(todos[0].description, insertData.description.value);
    });

    test("データベース作成時にデータが空であること", () async {
      expect(await todoDatabase.getTodos(), isEmpty);
    });
  });

  group('データ永続性テスト', () {
    test('再接続後のデータ永続性', () async {
      final dbFile =
          File(join(Directory.systemTemp.createTempSync().path, 'test.db'));
      final firstDb = AppDatabase(NativeDatabase(dbFile));

      expect(await firstDb.getTodos(), isEmpty);
      await firstDb.insertTodo(TodoCompanion.insert(
          title: 'Persistent Todo',
          createdAt: DateTime.now(),
          isComplete: false));
      await firstDb.close();

      final secondDb = AppDatabase(NativeDatabase(dbFile));
      final todos = await secondDb.getTodos();
      expect(todos, hasLength(1));
      dbFile.delete();
    });
  });
}
