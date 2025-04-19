import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_list_provider.dart';
import 'package:training_todo/util/command.dart';
import 'package:training_todo/util/result.dart';

import '../../../repositories/todo/todo_repository.dart';

class TopViewmodelDatabase extends ChangeNotifier {
  final TodoRepository _appDatabase;
  final TodoListProvider _todoListProvider;
  late Command1<void, bool> filterWithCompleted;

  TopViewmodelDatabase(this._appDatabase, this._todoListProvider) {
    filterWithCompleted = Command1(_filterWithCompleted);
  }

  Future<Result<void>> _filterWithCompleted(bool isComplete) async {
    final newTodoList =
        await _appDatabase.getItemsByCompletionStatus(isComplete);
    switch (newTodoList) {
      case Ok<List<TodoItem>>():
        _todoListProvider.todoList = newTodoList.value;
        return Result.ok(null);
      case Error<List<TodoItem>>():
        return Result.error(newTodoList.error);
    }
  }
}
