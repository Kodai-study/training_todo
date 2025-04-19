import 'package:training_todo/services/database/app_database.dart';

class TodoItem {
  final int id;
  final String title;
  final DateTime? deadline;
  final DateTime createdAt;
  final String? description;
  final DateTime? completion;
  final bool isComplete;

  TodoItem(this.id, this.title, this.createdAt, this.isComplete,
      {this.deadline, this.description, this.completion});

  TodoData toDatabaseData() {
    return TodoData(
        id: id, title: title, createdAt: createdAt, isComplete: isComplete);
  }

  factory TodoItem.convert(TodoData data) {
    return TodoItem(
      data.id,
      data.title,
      data.createdAt,
      data.isComplete,
      deadline: data.deadline,
      description: data.description,
      completion: data.completion,
    );
  }
}
