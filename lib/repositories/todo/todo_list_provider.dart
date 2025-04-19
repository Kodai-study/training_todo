import 'package:flutter/cupertino.dart';
import 'package:training_todo/util/result.dart';

import '../../model/todo_item.dart';

class TodoListProvider extends ChangeNotifier {
  List<TodoItem> _todoList = [];
  List<TodoItem> _listBackUp = [];
  Exception? _error;

  List<TodoItem> get todoList => _todoList;

  Exception? get error => _error;

  set todoList(List<TodoItem> value) {
    _todoList = value;
    notifyListeners();
  }

  Future<void> updateTodo(Future<Result<List<TodoItem>>> Function() fetcher) async {
    final result = await fetcher();
    if (result is Ok<List<TodoItem>>) {
      _todoList = result.value;
    } else if (result is Error<List<TodoItem>>) {
      _error = result.error;
    }
    notifyListeners();
  }

  void delete(int id) {
    _listBackUp = [..._todoList];
    _todoList.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void add(TodoItem value) {
    _listBackUp = [..._todoList];
    _todoList.add(value);
    notifyListeners();
  }

  void rollBack(){
    _todoList = _listBackUp;
    notifyListeners();
  }
}
