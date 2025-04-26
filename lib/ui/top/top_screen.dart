import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/ui/top/todo_list.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TopViewmodel>().loadList.execute();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("data"),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "未完了"),
            Tab(text: "完了済み"),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          TodoList(isCompleted: false),
          TodoList(isCompleted: true)
        ]),
      ),
    );
  }
}
