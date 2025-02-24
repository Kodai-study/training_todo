import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/ui/top/todo_list_provider.dart';
import 'package:training_todo/ui/top/todo_list_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListProvider>(
      builder: (_, provider, child) {
        return ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              TodoListTile(todoData: provider.todoList[i]),
              Divider()
            ],
          ),
          itemCount: provider.todoList.length,
        );
      },
    );
  }
}
