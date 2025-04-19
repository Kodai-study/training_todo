import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/todo/todo_list_provider.dart';
import 'package:training_todo/ui/top/todo_list.dart';

import '../../model/todo_item.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TodoListProvider>()
          .add(TodoItem(1, "title", DateTime.now(), false));
    });
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: TodoList(),
    );
  }
}
