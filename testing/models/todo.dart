import 'package:drift/drift.dart';
import 'package:training_todo/services/database/app_database.dart';

final kTodoData = TodoData(
    id: 0, title: '', createdAt: DateTime(2025, 1, 1), isComplete: false);

final kTodoCompanion = TodoCompanion.insert(
    title: "title",
    createdAt: DateTime(2025, 1, 1),
    isComplete: false,
    description: Value("Task description"),
    deadline: Value(DateTime(2025, 2, 1)));
