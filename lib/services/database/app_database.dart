import 'package:drift/drift.dart';
import 'package:training_todo/services/database/user_table.dart';

part 'app_database.g.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  DateTimeColumn get deadline => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get completion => dateTime().nullable()();

  BoolColumn get isComplete => boolean()();

  IntColumn get userId => integer().references(UserTable, #id).nullable()();
}

typedef TodoQuery = void Function(SimpleSelectStatement<$TodoTable, TodoData>);

@DriftDatabase(tables: [Todo, UserTable])
class AppDatabase extends _$AppDatabase {
  final List<OrderingTerm Function($TodoTable)> defaultOrderBy = [
    (todo) => OrderingTerm(expression: todo.deadline, mode: OrderingMode.desc)
  ];

  AppDatabase(QueryExecutor nativeDatabase)
      : super(LazyDatabase(() async => nativeDatabase));

  @override
  int get schemaVersion => 1;

  Future<int> updateTodo(TodoCompanion newTodo) async {
    var statement = update(todo)
      ..where((item) => item.id.equals(newTodo.id.value));
    return await statement.write(newTodo);
  }

  Future<Object> deleteTodo(int id) async {
    var deleteStatement = delete(todo)..where((item) => item.id.equals(id));
    return await deleteStatement.go();
  }

  Future<List<TodoData>> getTodos({TodoQuery? query}) async {
    final selector = select(todo);
    if (query != null) query(selector);
    return await selector.get();
  }

  Future<int> insertTodo(TodoCompanion newTodo) async {
    return await into(todo).insert(newTodo);
  }

  Future<int> insertUser(UserTableCompanion newUser) async {
    return await into(userTable).insert(newUser);
  }
}
