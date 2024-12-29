import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'todo.g.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  DateTimeColumn get deadline => dateTime()();

  TextColumn get description => text()();
}

@DriftDatabase(tables: [Todo])
class TodoDatabase extends _$TodoDatabase {
  final File dbFile;

  TodoDatabase(this.dbFile) : super(_openConnection(dbFile));

  Future<List<TodoData>> getTodos() {
    return select(todo).get();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(File file) {
  return LazyDatabase(() async {
    return NativeDatabase(file);
  });
}
