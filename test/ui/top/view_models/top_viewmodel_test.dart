import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/extension/change_notifier_extension.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/util/result.dart';

import '../../../../testing/mocks/app_database_mock.mocks.dart';
import '../../../../testing/models/todo.dart';

void main() {
  late MockTodoRepository mockTodoRepository;
  late TopViewmodel topViewModel;
  setUp(() {
    mockTodoRepository = MockTodoRepository();
    topViewModel = TopViewmodel(mockTodoRepository);
    provideDummy<Result<List<TodoItem>>>(Result.ok(<TodoItem>[]));
    provideDummy<Result<TodoItem>>(Result.ok(kTodoItem));
  });

  group("Todoリストの取得(loadList)", () {
    setUp(() {
      expect(topViewModel.completedList, isEmpty);
      expect(topViewModel.unCompletedList, isEmpty);
    });

    test("完了済みと未完了の両方の取得処理が動いていることの確認", () async {
      await topViewModel.loadList.execute();

      verify(mockTodoRepository.getItemsByCompletionStatus(true,
              query: anyNamed("query")))
          .called(1);
      verify(mockTodoRepository.getItemsByCompletionStatus(false,
              query: anyNamed("query")))
          .called(1);

      expect(topViewModel.loadList.result, isA<Ok>());
    });

    test("完了済みが１件ある場合、完了済みリストのみ1件になる", () async {
      when(mockTodoRepository.getItemsByCompletionStatus(true,
              query: anyNamed("query")))
          .thenAnswer((_) => Future.value(Result.ok(<TodoItem>[kTodoItem])));

      await topViewModel.loadList.awaitNotifyListeners(
          block: topViewModel.loadList.execute, expectedCount: 2);
      expect(topViewModel.completedList, hasLength(1));
      expect(topViewModel.unCompletedList, hasLength(0));
    });

    test("完了済みの取得でエラーが発生した場合、取得関数自体がエラーになる", () async {
      when(mockTodoRepository.getItemsByCompletionStatus(true,
              query: anyNamed("query")))
          .thenAnswer((_) async => Result.error(Exception()));

      await topViewModel.loadList.execute();
      expect(topViewModel.loadList.error, true);
    });

    test("未完了リストの取得でエラーが発生した場合、取得関数自体がエラーになる", () async {
      when(mockTodoRepository.getItemsByCompletionStatus(false,
              query: anyNamed("query")))
          .thenAnswer((_) async => Result.error(Exception()));

      await topViewModel.loadList.execute();
      expect(topViewModel.loadList.error, true);
    });
  });

  group("タスクの追加(addTodo)", () {
    setUp(() {
      expect(topViewModel.completedList, isEmpty);
      expect(topViewModel.unCompletedList, isEmpty);
    });

    test("未完了タスクを追加すると、完了済みリストにデータが追加される ", () async {
      await topViewModel.addTodo.execute(kTodoItem);
      verify(mockTodoRepository.insertTodo(kTodoItem)).called(1);
      expect(topViewModel.completedList, hasLength(0));
      expect(topViewModel.unCompletedList, hasLength(1));
    });

    test("完了済みタスクを追加すると、完了済みリストにデータが追加される ", () async {
      await topViewModel.addTodo.execute(kTodoItemCompleted);
      verify(mockTodoRepository.insertTodo(kTodoItemCompleted)).called(1);
      expect(topViewModel.completedList, hasLength(1));
      expect(topViewModel.unCompletedList, hasLength(0));
    });

    test("DBへの挿入が失敗したときにロールバックすること_完了済みリスト", () async {
      when(mockTodoRepository.insertTodo(kTodoItemCompleted))
          .thenThrow(Exception());

      bool checked = false;
      topViewModel.addListener(() {
        if (checked) return;
        expect(topViewModel.completedList, hasLength(1));
        checked = true;
      });

      await topViewModel.addTodo.execute(kTodoItemCompleted);

      expect(topViewModel.completedList, isEmpty);
      expect(topViewModel.addTodo.result, isA<Error>());
    });

    test("DBへの挿入が失敗したときにロールバックすること_未完了リスト", () async {
      when(mockTodoRepository.insertTodo(kTodoItem)).thenThrow(Exception());
      bool checked = false;

      topViewModel.addListener(() {
        if (checked) return;
        expect(topViewModel.unCompletedList, hasLength(1));
        checked = true;
      });

      await topViewModel.addTodo.execute(kTodoItem);
      expect(topViewModel.unCompletedList, isEmpty);
    });
  });
}
