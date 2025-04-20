import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/command.dart';
import 'package:training_todo/util/result.dart';

import '../../../repositories/todo/todo_repository.dart';

class TopViewmodel extends ChangeNotifier {
  final TodoRepository _appDatabase;
  late Command1<void, bool> filterWithCompleted;
  List<TodoItem> _todoList = [];
  late Command1<void, TodoItem> addTodo;

  static final _defaultQuery =
      TodoTableQuery(orderProperty: "deadLine", orderBy: OrderByMethod.ask);
  TodoTableQuery _query = _defaultQuery;

  List<TodoItem> get todoList => _todoList;

  TopViewmodel(this._appDatabase) {
    filterWithCompleted = Command1(_filterWithCompleted);
    addTodo = Command1(_addTodo);
  }

  Future<Result<void>> _filterWithCompleted(bool isComplete) async {
    final newTodoList = await _appDatabase
        .getItemsByCompletionStatus(isComplete, query: _query);
    switch (newTodoList) {
      case Ok<List<TodoItem>>():
        _todoList = newTodoList.value;
        return Result.ok(null);
      case Error<List<TodoItem>>():
        return Result.error(newTodoList.error);
    }
  }

  Future<Result<void>> _addTodo(TodoItem item) async {
    _todoList.add(item);
    try {
      await _appDatabase.insertTodo(item);
      return Result.ok(null);
    } on Exception catch (e) {
      _todoList.remove(item);
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
