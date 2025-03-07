import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/todo.dart';
import 'package:training_todo/ui/top/todo_list_provider.dart';

import 'todo_list_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoDatabase>()])
void main() {
  var mockTodoDatabase = MockTodoDatabase();

  final testTodoData = [
    TodoData(id: 1, title: "title", isComplete: false),
    TodoData(id: 2, title: "title2", isComplete: true)
  ];

  test("description", () async {
    final provider = TodoListProvider(mockTodoDatabase);
    await waitForInitialization(provider);
    expect(provider.todoList, isEmpty);
  });

  test("description2", () async {
    when(mockTodoDatabase.getTodos()).thenAnswer((_) async => testTodoData);
    final provider = TodoListProvider(mockTodoDatabase);
    await waitForInitialization(provider);
    expect(provider.todoList, testTodoData);
  });

  test("description3", () async {
    final mockTodoDatabase = MockTodoDatabase();
    final provider = TodoListProvider(mockTodoDatabase);
    await waitForInitialization(provider);
    expect(provider.todoList, isEmpty);
    final firstData = TodoData(id: 0, title: "title", isComplete: true);
    final secondData = TodoData(id: 1, title: "title1", isComplete: false);

    await provider.addTodo(firstData);
    expect(provider.todoList, hasLength(1));
    expect(provider.todoList.first, firstData);
    await provider.addTodo(secondData);
    expect(provider.todoList, hasLength(2));
    expect(provider.todoList[1], secondData);
    verify(mockTodoDatabase.getTodos()).called(1);
    verify(mockTodoDatabase.insertTodo(any)).called(2);
  });
}

// 非同期処理完了待機用ヘルパー
Future<void> waitForInitialization(TodoListProvider provider) async {
  while (provider.isLoading) {
    await Future.delayed(const Duration(milliseconds: 10));
  }
}
