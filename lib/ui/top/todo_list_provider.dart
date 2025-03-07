import 'package:flutter/cupertino.dart';
import 'package:training_todo/model/todo.dart';

class TodoListProvider with ChangeNotifier {
  List<TodoData> _todoList = [];
  final TodoDatabase todoDatabase;
  bool _isLoading = false;
  Object? _error;

  TodoListProvider(this.todoDatabase) {
    _initialize();
  }

  bool get isLoading => _isLoading;

  Object? get error => _error;

  List<TodoData> get todoList => _todoList;

  Future<void> _initialize() async {
    try {
      _isLoading = true;
      notifyListeners();
      _todoList = await todoDatabase.getTodos();
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(TodoData item) async {
    try {
      _isLoading = true;
      await todoDatabase.insertTodo(item);
      _todoList.add(item);
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
