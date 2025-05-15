import 'package:drift/drift.dart' hide JsonKey;
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
    bool isComplete, {
    /// タスクの詳細の説明文
    String? description,

    /// タスクの完了日時。完了されるまではnull
    DateTime? completion,

    /// タスクの期日。設定しなくてもよい
    DateTime? deadline,

    /// タスクを登録したユーザのID。未ログインの場合はnull
    int? userId,
  }) = _TodoItem;

  const TodoItem._();

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  TodoData toDatabaseData() {
    return TodoData(
        id: id,
        title: title,
        createdAt: createdAt,
        isComplete: isComplete,
        userId: userId);
  }

  TodoCompanion toCompanion() {

    return TodoCompanion.insert(
        title: title,
        createdAt: createdAt,
        isComplete: isComplete,
        description: description != null
            ? Value(description!)
            : const Value.absent(),
        deadline: deadline != null
            ? Value(deadline!)
            : const Value.absent(),
        userId: userId != null ? Value(userId!) : const Value.absent());
  }

  factory TodoItem.convert(TodoData data) {
    return TodoItem(data.id, data.title, data.createdAt, data.isComplete,
        deadline: data.deadline,
        description: data.description,
        completion: data.completion,
        userId: data.userId);
  }
}
