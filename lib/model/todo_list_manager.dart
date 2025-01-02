import 'package:training_todo/model/entity/todo.dart';

class TodoListManager {
  List<TodoData>? items;
  TodoDatabase database;

  TodoListManager(this.database);

  Future<List<TodoData>> get data async {
    items ??= await database.getTodos();
    return items!;
  }

  Future<void> add(TodoData todo) async {
    await database.insertTodo(todo);
    (await data).add(todo);
  }

  void clearCache() {
    items = null;
  }
}
