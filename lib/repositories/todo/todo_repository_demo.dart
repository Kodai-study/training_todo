import 'dart:math';

import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/result.dart';

class TodoRepositoryDemo extends TodoRepository {
  final _baseList = _createDemoList(100);

  @override
  Future<Result<TodoItem>> changeTodo(TodoItem newTodo) {
    // TODO: implement changeTodo
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TodoItem>>> getAllItem({TodoTableQuery? query}) async =>
      Result.ok(_baseList);

  @override
  Future<Result<List<TodoItem>>> getItemsByCompleteTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query}) async {
    final result = _baseList.where((element) =>
        element.completion != null &&
        element.completion!.isAfter(first) &&
        element.completion!.isBefore(end));
    return Result.ok(result.toList());
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByCompletionStatus(bool isCompleted,
      {TodoTableQuery? query}) {
    final result =
        _baseList.where((element) => element.isComplete == isCompleted);
    return Future.value(Result.ok(result.toList()));
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByCreateTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query}) {
    final result = _baseList.where((element) =>
        element.createdAt.isAfter(first) && element.createdAt.isBefore(end));
    return Future.value(Result.ok(result.toList()));
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByDeadline(
      {DateTime? first, DateTime? end, TodoTableQuery? query}) {
    final result =
        _baseList.where((element) => element.deadline != null && first == null
            ? true
            : element.deadline!.isAfter(first!) && end == null
                ? true
                : element.deadline!.isBefore(end!));
    return Future.value(Result.ok(result.toList()));
  }

  @override
  Future<Result<TodoItem>> insertTodo(TodoItem newTodo) {
    _baseList.add(newTodo);
    return Future.value(Result.ok(newTodo));
  }
}

List<TodoItem> _createDemoList(int count) {
  final baseDate = DateTime(2025, 1, 1);
  return List.generate(count, (index) {
    int random = Random().nextInt(100);
    bool isComplete = random % 2 == 0;
    return TodoItem(
      index,
      'Todo Item $index',
      baseDate.add(Duration(days: random)),
      isComplete,
      completion: isComplete ? baseDate.add(Duration(days: random + 1)) : null,
    );
  });
}
