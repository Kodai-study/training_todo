import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/entity/todo.dart';
import 'package:training_todo/model/todo_list_manager.dart';

import 'todo_list_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoListManager>(), MockSpec<TodoDatabase>()])
void main() {
  group("データの取得、追加の正常系テスト", () {
    final mockTodoDatabase = MockTodoDatabase();
    test("データ取得がdatabaseから行われていることの確認", () async {
      final mockTodoListManager = TodoListManager(mockTodoDatabase);
      when(mockTodoDatabase.getTodos()).thenAnswer((_) async => []);
      expect(await mockTodoListManager.data, isEmpty);
      verify(mockTodoDatabase.getTodos()).called(1);
    });

    test("連続でデータ取得しても、キャッシュを削除するまで再度DBからの読み込みが行われない事", () async {
      final mockTodoListManager = TodoListManager(mockTodoDatabase);
      when(mockTodoDatabase.getTodos())
          .thenAnswer((_) async => generateDefaultTodos(1));
      expect(await mockTodoListManager.data, hasLength(1));
      when(mockTodoDatabase.getTodos())
          .thenAnswer((_) async => generateDefaultTodos(3));
      expect(await mockTodoListManager.data, hasLength(1));
      verify(mockTodoDatabase.getTodos()).called(1);
    });

    test("キャッシュを削除した場合、再度DBから読み取りが行われること", () async {
      final mockTodoListManager = TodoListManager(mockTodoDatabase);
      when(mockTodoDatabase.getTodos())
          .thenAnswer((_) async => generateDefaultTodos(1));
      expect(await mockTodoListManager.data, hasLength(1));
      mockTodoListManager.clearCache();
      when(mockTodoDatabase.getTodos())
          .thenAnswer((_) async => generateDefaultTodos(3));
      expect(await mockTodoListManager.data, hasLength(3));
      verify(mockTodoDatabase.getTodos()).called(2);
    });
  });
}

List<TodoData> generateDefaultTodos(int size) {
  return List.generate(
      size,
      (index) => TodoData(
            id: index,
            title: "title$index",
            deadline: DateTime(2000).add(Duration(days: index)),
            description: 'description$index',
          ));
}
