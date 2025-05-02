// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/util/result.dart';

import 'models/todo.dart';

Future<void> testApp(WidgetTester tester, Widget body) async {
  provideDummy<Result<List<TodoItem>>>(Result.ok(<TodoItem>[]));
  provideDummy<Result<TodoItem>>(Result.ok(kTodoItem));
  tester.view.devicePixelRatio = 1.0;
  await tester.binding.setSurfaceSize(const Size(1200, 800));
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: body,
      ),
    ),
  );
}
