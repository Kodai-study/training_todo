// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => _TodoItem(
      (json['id'] as num).toInt(),
      json['title'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['isComplete'] as bool,
      description: json['description'] as String?,
      completion: json['completion'] == null
          ? null
          : DateTime.parse(json['completion'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TodoItemToJson(_TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'isComplete': instance.isComplete,
      'description': instance.description,
      'completion': instance.completion?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'userId': instance.userId,
    };
