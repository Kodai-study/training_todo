import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/command.dart';
import 'package:training_todo/util/result.dart';

import '../../../repositories/todo/todo_repository.dart';

class TopViewmodel extends ChangeNotifier {
  final TodoRepository _todoRepository;
  List<TodoItem> _completedList = [];
  List<TodoItem> _unCompletedList = [];
  static final _defaultQuery =
      TodoTableQuery(orderProperty: "deadLine", orderBy: OrderByMethod.ask);
  TodoTableQuery _query = _defaultQuery;

  late Command1<void, TodoItem> addTodo;
  late Command0<void> loadList;

  List<TodoItem> get completedList => _completedList;

  List<TodoItem> get unCompletedList => _unCompletedList;

  TopViewmodel(this._todoRepository) {
    addTodo = Command1(_addTodo);
    loadList = Command0(_loadList);
  }

  Future<Result<void>> _addTodo(TodoItem item) async {
    if (item.isComplete) {
      _completedList.add(item);
    } else {
      _unCompletedList.add(item);
    }
    notifyListeners();

    try {
      await _todoRepository.insertTodo(item);
      return Result.ok(null);
    } on Exception catch (e) {
      if (item.isComplete) {
        _completedList.remove(item);
      } else {
        _unCompletedList.remove(item);
      }
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _loadList() async {
    final getResult =
        await _todoRepository.getItemsByCompletionStatus(true, query: _query);
    switch (getResult) {
      case Error<List<TodoItem>>():
        return Result.error(getResult.error);
      case Ok<List<TodoItem>>():
        _completedList = getResult.value;
    }

    final getInCompletedList =
        await _todoRepository.getItemsByCompletionStatus(false, query: _query);
    switch (getInCompletedList) {
      case Error<List<TodoItem>>():
        return Result.error(getInCompletedList.error);
      case Ok<List<TodoItem>>():
        _unCompletedList = getInCompletedList.value;
    }
    notifyListeners();
    return Result.ok(null);
  }
}
