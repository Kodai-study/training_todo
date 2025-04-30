import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:training_todo/services/database/app_database.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
abstract class TodoItem with _$TodoItem {
  factory TodoItem(int id, String title, DateTime createdAt, bool isComplete,
      {String? description,
      DateTime? completion,
      DateTime? deadline}) = _TodoItem;

  const TodoItem._();

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  TodoData toDatabaseData() {
    return TodoData(
        id: id, title: title, createdAt: createdAt, isComplete: isComplete);
  }

  TodoCompanion toCompanion() {
    return TodoCompanion.insert(
        title: title, createdAt: createdAt, isComplete: isComplete);
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
