import 'package:flutter/material.dart';
import 'package:training_todo/extension/datetime_extension.dart';
import 'package:training_todo/model/todo.dart';

class TodoListTile extends StatelessWidget {
  final TodoData todoData;

  const TodoListTile({
    super.key,
    required this.todoData,
  });

  @override
  Widget build(BuildContext context) {
    final leadingIcon = Icon(todoData.isComplete
        ? Icons.check_box_outlined
        : Icons.check_box_outline_blank);

    return ListTile(
      title: Text(todoData.title),
      leading: IconButton(onPressed: null, icon: leadingIcon),
      trailing: todoData.deadline != null
          ? Text(todoData.deadline!.formatAsYMD())
          : null,
    );
  }
}
