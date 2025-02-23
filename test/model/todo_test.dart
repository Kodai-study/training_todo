import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:training_todo/model/todo.dart';

void main() {
  late TodoDatabase todoDatabase;
  group("ToDoデータベースの基本試験", () {
    setUp(() async {
      todoDatabase = TodoDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await todoDatabase.close();
    });

    test('Todoの挿入と取得', () async {
      final currentDateTime = DateTime.now();

      var insertData = TodoData(
        id: 0,
        // autoIncrementで無視される
        title: 'Test Todo',
        deadline: currentDateTime,
        description: 'Test Description',
        isComplete: false,
      );
      await todoDatabase.insertTodo(insertData);

      final clearMilliSeconds = currentDateTime.subtract(Duration(
          milliseconds: currentDateTime.millisecond,
          microseconds: currentDateTime.microsecond));

      final todos = await todoDatabase.getTodos();
      expect(todos, hasLength(1));
      expect(todos[0].title, insertData.title);
      expect(todos[0].deadline, clearMilliSeconds);
      expect(todos[0].description, insertData.description);
    });

    test("データベース作成時にデータが空であること", () async {
      expect(await todoDatabase.getTodos(), isEmpty);
    });
  });

  group('データ永続性テスト', () {
    test('再接続後のデータ永続性', () async {
      final dbFile =
          File(join(Directory.systemTemp.createTempSync().path, 'test.db'));
      final firstDb = TodoDatabase(NativeDatabase(dbFile));

      expect(await firstDb.getTodos(), isEmpty);
      await firstDb.insertTodo(TodoData(
          id: 0,
          title: 'Persistent Todo',
          deadline: DateTime.now(),
          description: 'Test',
          isComplete: false));
      await firstDb.close();

      final secondDb = TodoDatabase(NativeDatabase(dbFile));
      final todos = await secondDb.getTodos();
      expect(todos, hasLength(1));
      dbFile.delete();
    });
  });
}
