import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository_database.dart';
import 'package:training_todo/routing/router.dart';
import 'package:training_todo/services/database/app_database.dart';

import 'repositories/todo/todo_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbFloder = await getApplicationDocumentsDirectory();
  final file = File(join(dbFloder.path, 'db.sqlite'));
  final repository = TodoRepositoryDatabase(AppDatabase(NativeDatabase(file)));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TodoListProvider>(
          create: (context) => TodoListProvider()),
      Provider<TodoRepository>.value(
        value: repository,
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
