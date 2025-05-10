import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/repositories/auth/auth_repository_demo.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository_demo.dart';

import 'main.dart';

void main() async {
  runApp(MultiProvider(providers: _providersDemo, child: const MyApp()));
}

final _providersDemo = [
  Provider<TodoRepository>(
    create: (context) => TodoRepositoryDemo(),
  ),
  ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryDemo()),
];
