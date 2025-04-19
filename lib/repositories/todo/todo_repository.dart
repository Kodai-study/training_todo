import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/result.dart';


abstract class TodoRepository {
  Future<Result<List<TodoItem>>> getItemsByCompletionStatus(bool isCompleted,
      {TodoTableQuery? query});

  Future<Result<List<TodoItem>>> getItemsByDeadline(
      DateTime first, DateTime end,
      {TodoTableQuery? query});

  Future<Result<List<TodoItem>>> getItemsByCompleteTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query});

  Future<Result<List<TodoItem>>> getItemsByCreateTime(
      DateTime first, DateTime end,
      {TodoTableQuery? query});

  Future<Result<List<TodoItem>>> getAllItem({TodoTableQuery? query});

  Future<Result<TodoItem>> insertTodo(TodoItem newTodo);

  Future<Result<void>> deleteTodo(int id);

  Future<Result<TodoItem>> changeTodo(TodoItem newTodo);
}
