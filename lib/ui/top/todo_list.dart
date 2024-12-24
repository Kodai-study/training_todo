import 'package:flutter/material.dart';
import 'package:training_todo/model/entity/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.items});

  final List<Todo> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
          );
        });
  }
}
