import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:training_todo/services/database/app_database.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
abstract class TodoItem with _$TodoItem {
  factory TodoItem(

      /// タスクのID
      int id,

      /// タスクのタイトル。 1行で表示できる短いものを想定
      String title,

      /// タスクの作成日時
      DateTime createdAt,

      /// タスクが完了済みであるかどうか
      bool isComplete,
      {
      /// タスクの詳細の説明文
      String? description,

      /// タスクの完了日時。完了されるまではnull
      DateTime? completion,

      /// タスクの期日。設定しなくてもよい
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
