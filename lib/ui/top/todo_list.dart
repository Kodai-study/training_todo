import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/ui/top/todo_list_tile.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopViewmodel>(
      builder: (_, provider, child) {
        final list =
            isCompleted ? provider.completedList : provider.unCompletedList;

        return ListView.separated(
            itemBuilder: (_, i) => TodoListTile(todoData: list[i]),
            itemCount: list.length,
            separatorBuilder: (context, index) => Divider());
      },
    );
  }
}
