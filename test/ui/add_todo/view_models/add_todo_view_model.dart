import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/ui/add_todo/view_models/add_todo_view_model.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/util/result.dart';

import '../../../../testing/mocks/app_database_mock.mocks.dart';
import '../../../../testing/models/todo.dart';

void main() {
  late AddTodoViewModel viewModel;
  late TopViewmodel topViewmodel;
  late TodoRepository mockTodoRepository;

  provideDummy<Result<TodoItem>>(Result.ok(kTodoItem));

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    topViewmodel = TopViewmodel(mockTodoRepository);
    viewModel = AddTodoViewModel(topViewmodel);
  });

  group("タスクの新規追加", () {
    test("タスクの新規追加が正常に行えること", () async {
      await viewModel.createNewTask
          .execute(("title", "descriptoin", "2025-01-01"));
      expect(viewModel.createNewTask.completed, true);
    });

    test("トップ画面に新しく追加されること", () async {
      expect(topViewmodel.completedList, isEmpty);
      await viewModel.createNewTask
          .execute(("title", "descriptoin", "2025-01-01"));
      expect(topViewmodel.addTodo.completed, true);
      expect(topViewmodel.unCompletedList, hasLength(1));
    });
  });

  group("フォームの入力からタスクを生成する関数のテスト", () {
    test("全ての項目が入力されている場合", () {
      fakeAsync((FakeAsync fakeClock) async {
        final todoItem =
            viewModel.createTodoItem("title", "descriptoin", "2025-02-01");
        expect(todoItem.title, "title");
        expect(todoItem.description, "descriptoin");
        expect(todoItem.deadline, DateTime(2025, 2, 1));
        expect(todoItem.createdAt, DateTime(2025, 1, 1, 12, 30, 0));
        expect(todoItem.isComplete, false);
        expect(todoItem.userId, null);

      }, initialTime: DateTime(2025, 1, 1, 12, 30, 0));
    });

    test("詳細が入力されていない場合にnullになっていること", () {
      final todoItem = viewModel.createTodoItem("title", "", "2025-02-01");
      expect(todoItem.title, "title");
      expect(todoItem.description, null);
      expect(todoItem.deadline, DateTime(2025, 2, 1));
    });

    test("期限が入力されていない場合にnullになっていること", () {
      final todoItem = viewModel.createTodoItem("title", "descriptoin", "");
      expect(todoItem.title, "title");
      expect(todoItem.description, "descriptoin");
      expect(todoItem.deadline, null);
    });

    test("期限、詳細が入力されていない場合にnullになっていること", () {
      final todoItem = viewModel.createTodoItem("title", "", "");
      expect(todoItem.title, "title");
      expect(todoItem.description, null);
      expect(todoItem.deadline, null);
    });
  });
}
