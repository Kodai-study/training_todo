import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_list_provider.dart';
import 'package:training_todo/ui/top/top_page_body.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TodoListProvider>()
          .add(TodoItem(1, "title", DateTime.now(), true));
    });

    return ChangeNotifierProvider(
      create: (context) => TopViewmodelDatabase(context.read(), context.read()),
      child: Scaffold(
        body: TopPageBody(),
        appBar: AppBar(title: Text("data")),
      ),
    );
  }
}
