import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo.dart';

class TodoListProvider with ChangeNotifier {
  final List<TodoData> _todoList = [];

  List<TodoData> get todoList => _todoList;
}
