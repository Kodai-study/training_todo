import 'package:flutter/material.dart';
import 'package:training_todo/const/strings.dart';
import 'package:training_todo/model/entity/todo.dart';
import 'package:training_todo/ui/top/todo_list.dart';

class TopPage extends StatefulWidget {
  TopPage({super.key});

  final List<TodoData> items = [];

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(TopPageStrings.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: TodoList(items: widget.items)),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          setState(() {
            widget.items.add(TodoData(
                id: widget.items.length,
                title: "title${widget.items.length}",
                deadline: DateTime.now(),
                description: "description"));
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
