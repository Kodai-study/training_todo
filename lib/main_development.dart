import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/repositories/auth/auth_repository_demo.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository_demo.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: _providersDemo, child: MyApp()));
}

final _providersDemo = [
  Provider<TodoRepository>(
    create: (context) => TodoRepositoryDemo(),
  ),
  ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryDemo()),
  ChangeNotifierProvider(create: (context) => TopViewmodel(context.read())),
];
