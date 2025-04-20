import 'package:drift/drift.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/services/database/app_database.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/result.dart';

class TodoRepositoryDatabase implements TodoRepository {
  final AppDatabase appDatabase;

  TodoRepositoryDatabase(this.appDatabase);

  @override
  Future<Result<TodoItem>> changeTodo(newTodo) async {
    try {
      await appDatabase.updateTodo(newTodo.toCompanion());
      return Result.ok(newTodo);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteTodo(int id) async {
    try {
      await appDatabase.deleteTodo(id);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<TodoItem>> insertTodo(newTodo) async {
    try {
      await appDatabase.insertTodo(newTodo.toCompanion());
      return Result.ok(newTodo);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<TodoItem>>> getAllItem({TodoTableQuery? query}) async {
    try {
      final item = await appDatabase.getTodos((item) {
        if (query != null) doQuery(query, item);
      });
      final todoItem = item.map((item) => TodoItem.convert(item)).toList();
      return Result.ok(todoItem);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByCompleteTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query}) async {
    try {
      final item = await appDatabase.getTodos((selector) {
        if (query != null) doQuery(query, selector);
      });
      final todoItem = item.map((item) => TodoItem.convert(item)).toList();
      return Result.ok(todoItem);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByCompletionStatus(bool isCompleted,
      {TodoTableQuery? query}) async {
    try {
      final item = await appDatabase.getTodos((selector) {
        selector.where((todo) => todo.isComplete.equals(isCompleted));
        if (query != null) doQuery(query, selector);
      });
      final todoItem = item.map((item) => TodoItem.convert(item)).toList();
      return Result.ok(todoItem);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByCreateTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query}) {
    // TODO: implement getItemsByCreateTime
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TodoItem>>> getItemsByDeadline(
      DateTime first, DateTime end,
      {TodoTableQuery? query}) {
    // TODO: implement getItemsByDeadline
    throw UnimplementedError();
  }

  void doQuery(TodoTableQuery query,
      SimpleSelectStatement<$TodoTable, TodoData> selector) {
    final orderTerms = <OrderingTerm Function($TodoTable)>[];
    if (query.limit != null) {
      selector.limit(query.limit!, offset: query.offset);
    }

    if (query.orderProperty != null) {
      var mode = OrderingMode.asc;
      if (query.orderBy == OrderByMethod.desc) mode = OrderingMode.desc;
      OrderingTerm orderTerm($TodoTable todo) {
        switch (query.orderProperty) {
          case "deadline":
            return OrderingTerm(expression: todo.deadline, mode: mode);
          case "createdAt":
            return OrderingTerm(expression: todo.createdAt, mode: mode);
          case "completion":
            return OrderingTerm(expression: todo.completion, mode: mode);
          default:
            return OrderingTerm(expression: todo.id);
        }
      }

      orderTerms.add(orderTerm);
    }

    if (orderTerms.isNotEmpty) selector.orderBy(orderTerms);
  }
}
