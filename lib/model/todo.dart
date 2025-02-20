import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'todo.g.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  DateTimeColumn get deadline => dateTime().nullable()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get completion => dateTime().nullable()();

  BoolColumn get isComplete => boolean()();
}

@DriftDatabase(tables: [Todo])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase(QueryExecutor nativeDatabase)
      : super(LazyDatabase(() async {
          return nativeDatabase;
        }));

  Future<List<TodoData>> getTodos() {
    return select(todo).get();
  }

  @override
  int get schemaVersion => 1;
}
