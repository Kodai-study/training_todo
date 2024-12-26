import 'package:training_todo/model/entity/todo.dart';

class TodoListManager {
  List<Todo>? items;

  Future<List<Todo>> fetchData() async {
    return List.empty();
  }

  Future<List<Todo>> get data async {
    items ??= await fetchData();
    return items!;
  }
}
