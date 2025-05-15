import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/routing/routes.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/ui/top/widgets/todo_list.dart';
import 'package:training_todo/ui/top/widgets/user_profile_icon.dart';

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
          actions: <Widget>[
            UserProfileIcon(),
          ],
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "未完了"),
            Tab(text: "完了済み"),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            context.push(Routes.addTodo);
          },
        ),
        body: TabBarView(
          children: <Widget>[
            TodoList(isCompleted: false),
            TodoList(isCompleted: true)
          ],
        ),
      ),
    );
  }
}
