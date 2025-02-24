import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/ui/component/screen_base.dart';
import 'package:training_todo/ui/top/todo_list.dart';
import 'package:training_todo/ui/top/todo_list_provider.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      title: "トップ画面",
      body: ChangeNotifierProvider(
          create: (_) => TodoListProvider(), child: TodoList()),
    );
  }
}
