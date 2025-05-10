import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/repositories/auth/auth_repository_demo.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository_database.dart';
import 'package:training_todo/services/database/app_database.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(join(dbFolder.path, 'db.sqlite'));
  final repository = TodoRepositoryDatabase(AppDatabase(NativeDatabase(file)));
  runApp(MultiProvider(
    providers: _createProvidersRelease(repository),
    child: const MyApp(),
  ));
}

_createProvidersRelease(TodoRepository todoRepository) => [
      Provider<TodoRepository>.value(
        value: todoRepository,
      ),
      ChangeNotifierProvider<AuthRepository>(
          create: (context) => AuthRepositoryDemo()),
    ];
