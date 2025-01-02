import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:training_todo/model/entity/todo.dart';
import 'package:training_todo/model/todo_list_manager.dart';
import 'package:training_todo/ui/top/top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<TodoDatabase> _createDb() async {
    final dirPath = (await getApplicationDocumentsDirectory()).path;
    return TodoDatabase(File(join(dirPath, 'test.db')));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: _createDb(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return CircularProgressIndicator();
            }
            return TopPage(
              manager: TodoListManager(snapshot.data!),
            );
          }),
    );
  }
}
