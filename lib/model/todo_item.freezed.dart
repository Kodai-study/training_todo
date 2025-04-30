// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoItem {
  /// タスクのID
  int get id;

  /// タスクのタイトル。 1行で表示できる短いものを想定
  String get title;

  /// タスクの作成日時
  DateTime get createdAt;

  /// タスクが完了済みであるかどうか
  bool get isComplete;

  /// タスクの詳細の説明文
  String? get description;

  /// タスクの完了日時。完了されるまではnull
  DateTime? get completion;

  /// タスクの期日。設定しなくてもよい
  DateTime? get deadline;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoItemCopyWith<TodoItem> get copyWith =>
      _$TodoItemCopyWithImpl<TodoItem>(this as TodoItem, _$identity);

  /// Serializes this TodoItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, createdAt, isComplete,
      description, completion, deadline);

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, createdAt: $createdAt, isComplete: $isComplete, description: $description, completion: $completion, deadline: $deadline)';
  }
}

/// @nodoc
abstract mixin class $TodoItemCopyWith<$Res> {
  factory $TodoItemCopyWith(TodoItem value, $Res Function(TodoItem) _then) =
      _$TodoItemCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime createdAt,
      bool isComplete,
      String? description,
      DateTime? completion,
      DateTime? deadline});
}

/// @nodoc
class _$TodoItemCopyWithImpl<$Res> implements $TodoItemCopyWith<$Res> {
  _$TodoItemCopyWithImpl(this._self, this._then);

  final TodoItem _self;
  final $Res Function(TodoItem) _then;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? isComplete = null,
    Object? description = freezed,
    Object? completion = freezed,
    Object? deadline = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isComplete: null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completion: freezed == completion
          ? _self.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TodoItem extends TodoItem {
  _TodoItem(this.id, this.title, this.createdAt, this.isComplete,
      {this.description, this.completion, this.deadline})
      : super._();
  factory _TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  /// タスクのID
  @override
  final int id;

  /// タスクのタイトル。 1行で表示できる短いものを想定
  @override
  final String title;

  /// タスクの作成日時
  @override
  final DateTime createdAt;

  /// タスクが完了済みであるかどうか
  @override
  final bool isComplete;

  /// タスクの詳細の説明文
  @override
  final String? description;

  /// タスクの完了日時。完了されるまではnull
  @override
  final DateTime? completion;

  /// タスクの期日。設定しなくてもよい
  @override
  final DateTime? deadline;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoItemCopyWith<_TodoItem> get copyWith =>
      __$TodoItemCopyWithImpl<_TodoItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TodoItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodoItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, createdAt, isComplete,
      description, completion, deadline);

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, createdAt: $createdAt, isComplete: $isComplete, description: $description, completion: $completion, deadline: $deadline)';
  }
}

/// @nodoc
abstract mixin class _$TodoItemCopyWith<$Res>
    implements $TodoItemCopyWith<$Res> {
  factory _$TodoItemCopyWith(_TodoItem value, $Res Function(_TodoItem) _then) =
      __$TodoItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime createdAt,
      bool isComplete,
      String? description,
      DateTime? completion,
      DateTime? deadline});
}

/// @nodoc
class __$TodoItemCopyWithImpl<$Res> implements _$TodoItemCopyWith<$Res> {
  __$TodoItemCopyWithImpl(this._self, this._then);

  final _TodoItem _self;
  final $Res Function(_TodoItem) _then;

  /// Create a copy of TodoItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? isComplete = null,
    Object? description = freezed,
    Object? completion = freezed,
    Object? deadline = freezed,
  }) {
    return _then(_TodoItem(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completion: freezed == completion
          ? _self.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
