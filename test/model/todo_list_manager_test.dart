import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/entity/todo.dart';
import 'package:training_todo/model/todo_list_manager.dart';

import 'todo_list_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoListManager>(), MockSpec<TodoDatabase>()])
void main() {
  group("データの取得、追加の正常系テスト", () {
    final mockTodoDatabase = MockTodoDatabase();
    final mockTodoListManager = TodoListManager(mockTodoDatabase);

  });
}
