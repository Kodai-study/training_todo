import 'package:drift/drift.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/services/database/app_database.dart';

final kTodoData = TodoData(
    id: 0, title: '', createdAt: DateTime(2025, 1, 1), isComplete: false);

final kTodoItem = TodoItem(0, '', DateTime(2025, 1, 1), false,
    description: "詳細", deadline: DateTime(2025, 2, 1));

final kTodoItemCompleted = TodoItem(0, '', DateTime(2025, 1, 1), true,
    description: "詳細",
    deadline: DateTime(2025, 3, 1),
    completion: DateTime(2025, 2, 1));

List<TodoItem> createDefaultUncompletedTodoList(int size, {int offset = 0}) {
  final todoItemList = <TodoItem>[];
  for (int i = 0; i < size; i++) {
    final id = i + offset + 1;
    todoItemList.add(kTodoItem.copyWith(id: id, title: "title$id"));
  }
  return todoItemList;
}

List<TodoItem> createDefaultCompletedTodoList(int size, {int offset = 0}) {
  final todoItemList = <TodoItem>[];
  for (int i = 0; i < size; i++) {
    final id = i + offset + 1;
    todoItemList.add(kTodoItemCompleted.copyWith(id: id, title: "title$id"));
  }
  return todoItemList;
}

final kTodoCompanion = TodoCompanion.insert(
    title: "title",
    createdAt: DateTime(2025, 1, 1),
    isComplete: false,
    description: Value("Task description"),
    deadline: Value(DateTime(2025, 2, 1)));
