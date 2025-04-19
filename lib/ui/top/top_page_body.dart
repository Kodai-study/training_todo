import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_list_provider.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/ui/top/todo_list_tile.dart';

class TopPageBody extends StatelessWidget {
  const TopPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TodoRepository>()
          .insertTodo(TodoItem(1, "", DateTime.now(), false));
    });
    return Consumer<TodoListProvider>(
      builder: (_, provider, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (_, i) => Column(
            children: [
              TodoListTile(todoData: provider.todoList[i]),
            ],
          ),
          itemCount: provider.todoList.length,
        );
      },
    );
  }
}
