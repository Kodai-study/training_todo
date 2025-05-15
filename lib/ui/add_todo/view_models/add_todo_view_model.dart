import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/util/command.dart';
import 'package:training_todo/util/result.dart';

class AddTodoViewModel extends ChangeNotifier {
  final TopViewmodel _topViewmodel;

  /// タスクを新規追加する。
  ///
  /// 引数：
  /// (String title, String description, String deadline)
  ///
  /// title: タスクのタイトル
  /// description: タスクの詳細
  /// deadline: タスクの締切
  late Command1<void, (String, String, String)> createNewTask;

  AddTodoViewModel(this._topViewmodel) {
    createNewTask = Command1(_createNewTask);
  }

  Future<Result<void>> _createNewTask((String, String, String) item) async {
    final todoItem = createTodoItem(item.$1, item.$2, item.$3);
    await _topViewmodel.addTodo.execute(todoItem);
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
