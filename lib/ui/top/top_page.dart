import 'package:flutter/material.dart';
import 'package:training_todo/const/strings.dart';
import 'package:training_todo/model/entity/todo.dart';
import 'package:training_todo/model/todo_list_manager.dart';
import 'package:training_todo/ui/top/todo_list.dart';

class TopPage extends StatefulWidget {
  final TodoListManager manager;

  const TopPage({super.key, required this.manager});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  late List<TodoData> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(TopPageStrings.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: widget.manager.data,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              items = snapshot.data!;
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: TodoList(items: items)),
                  ]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () async {
          await widget.manager.add(TodoData(
              id: items.length,
              title: "title${items.length}",
              deadline: DateTime.now(),
              description: "description"));
          final updatedItem = await widget.manager.data;
          setState(() {
            items = updatedItem;
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
