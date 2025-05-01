import 'package:drift/drift.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/services/database/app_database.dart';

final kTodoData = TodoData(
    id: 0, title: '', createdAt: DateTime(2025, 1, 1), isComplete: false);

final kTodoItem = TodoItem(0, '', DateTime(2025, 1, 1), false,
    description: "詳細", deadline: DateTime(2025, 2, 1));

final kTodoItemCompleted = TodoItem(0, '', DateTime(2025, 1, 1), true,
    description: "詳細",
    deadline: DateTime(2025, 3, 1),
    completion: DateTime(2025, 2, 1));

final kTodoCompanion = TodoCompanion.insert(
    title: "title",
    createdAt: DateTime(2025, 1, 1),
    isComplete: false,
    description: Value("Task description"),
    deadline: Value(DateTime(2025, 2, 1)));
