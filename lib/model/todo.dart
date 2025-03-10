import 'package:drift/drift.dart';

part 'todo.g.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  DateTimeColumn get deadline => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

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

  Future<void> insertTodo(TodoData newTodo) async {
    await into(todo).insert(newTodo);
  }

  @override
  int get schemaVersion => 1;
}
