import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/util/command.dart';
import 'package:training_todo/util/result.dart';

class AddTodoViewModel extends ChangeNotifier {
  final TopViewmodel _topViewmodel;
  late Command1<void, TodoItem> createNewTask;

  AddTodoViewModel(this._topViewmodel) {
    createNewTask = Command1(_createNewTask);
  }

  Future<Result<void>> _createNewTask(TodoItem item) async {
    await _topViewmodel.addTodo.execute(item);
    if (_topViewmodel.addTodo.error) {
      return Result.error((_topViewmodel.addTodo.result as Error).error);
    }
    return Result.ok(null);
  }

  @visibleForTesting
  TodoItem createTodoItem(
    String title,
    String description,
    String deadlineStr,
  ) {
    return TodoItem(
      0,
      title,
      clock.now(),
      false,
      description: description.isEmpty ? null : description,
      deadline: deadlineStr.isEmpty
          ? null
          : DateTime.parse(deadlineStr.replaceAll("/", "-")),
    );
  }
}
