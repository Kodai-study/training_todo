import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/todo_item.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository_database.dart';
import 'package:training_todo/services/database/app_database.dart';
import 'package:training_todo/services/database/todo_table_query.dart';
import 'package:training_todo/util/result.dart';

import '../../../testing/mocks/app_database_mock.mocks.dart';
import '../../../testing/models/todo.dart';

void main() {
  group("DBモックを使用した単体試験", () {
    late AppDatabase mockAppDatabase;
    late TodoRepository fakeTodoRepository;
    setUp(() {
      mockAppDatabase = MockAppDatabase();
      fakeTodoRepository = TodoRepositoryDatabase(mockAppDatabase);
    });

    test("空データ", () async {
      final result = await fakeTodoRepository.getItemsByCompletionStatus(false);
      expect((result as Ok<List<TodoItem>>).value, isEmpty);
    });

    test("テストデータ(サイズ1)", () async {
      when(mockAppDatabase.getTodos(query: anyNamed("query")))
          .thenAnswer((_) async => [kTodoData]);
      final result = await fakeTodoRepository.getItemsByCompletionStatus(false);
      expect((result as Ok<List<TodoItem>>).value, hasLength(1));
    });

    test("DBのselectでエラーが発生した場合", () async {
      when(mockAppDatabase.getTodos(query: anyNamed("query")))
          .thenThrow(Exception());
      final result = await fakeTodoRepository.getItemsByCompletionStatus(false);
      expect(result, isA<Error>());
    });
  });

  group("DBを使用した統合試験", () {
    late AppDatabase appDatabase;
    late TodoRepository fakeTodoRepository;
    setUp(() async {
      appDatabase = AppDatabase(NativeDatabase.memory());
      fakeTodoRepository = TodoRepositoryDatabase(appDatabase);

      await appDatabase.insertTodo(kTodoCompanion);
    });

    tearDown(() {
      appDatabase.close();
    });

    group("完了済みかどうかのフィルタリング(getItemsByCompletionStatus)", () {
      setUp(() async {
        final completedItem =
            kTodoCompanion.copyWith(id: Value(2), isComplete: Value(true));
        await appDatabase.insertTodo(completedItem);
      });

      test("完了済み一覧の取得", () async {
        final completedList =
            await fakeTodoRepository.getItemsByCompletionStatus(true);
        expect((completedList as Ok<List<TodoItem>>).value, hasLength(1));
        expect(completedList.value[0].id, 2);
      });

      test("未完了一覧の取得", () async {
        final inCompletedList =
            await fakeTodoRepository.getItemsByCompletionStatus(false);
        expect((inCompletedList as Ok<List<TodoItem>>).value, hasLength(1));
        expect(inCompletedList.value[0].id, 1);
      });
    });

    group("並び替え、リミットの試験", () {
      group("作成日付順で並び替え", () {
        setUp(() async {
          final insertTimes = [
            DateTime(2025, 1, 1).subtract(Duration(microseconds: 1)), //1月1日未満
            DateTime(2025, 1, 1, 0, 0, 1), //1月1日より大きい
            DateTime(2025, 1, 2).subtract(Duration(microseconds: 1)), //1月2日未満
            DateTime(2025, 1, 3),
          ];
          for (int i = 0; i < insertTimes.length; i++) {
            await appDatabase.insertTodo(kTodoCompanion.copyWith(
                id: Value(i + 2), createdAt: Value(insertTimes[i])));
          }
        });

        test("mode未指定", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(orderProperty: "createdAt"));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list.map((item) => item.id).toList(), [2, 1, 3, 4, 5]);
        });

        test("asc", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(
                  orderProperty: "createdAt", orderBy: OrderByMethod.ask));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list.map((item) => item.id).toList(), [2, 1, 3, 4, 5]);
        });

        test("desc", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(
                  orderProperty: "createdAt", orderBy: OrderByMethod.desc));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list.map((item) => item.id).toList(), [5, 4, 3, 1, 2]);
        });
      });

      group("期日で並び替え", () {
        setUp(() async {
          final insertTimes = [
            DateTime(2025, 2, 1).subtract(Duration(microseconds: 1)), //1月1日未満
            DateTime(2025, 2, 1, 0, 0, 1), //1月1日より大きい
            DateTime(2025, 2, 2).subtract(Duration(microseconds: 1)), //1月2日未満
            DateTime(2025, 2, 3),
          ];
          for (int i = 0; i < insertTimes.length; i++) {
            await appDatabase.insertTodo(kTodoCompanion.copyWith(
                id: Value(i + 2), deadline: Value(insertTimes[i])));
          }
        });

        test("orderBy asc", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(
                  orderProperty: "deadline", orderBy: OrderByMethod.ask));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list.map((item) => item.id).toList(), [2, 1, 3, 4, 5]);
        });

        test("orderBy desc", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(
                  orderProperty: "deadline", orderBy: OrderByMethod.desc));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list.map((item) => item.id).toList(), [5, 4, 3, 1, 2]);
        });
      });

      group("limit,offsetの試験", () {
        setUp(() async {
          for (int i = 2; i <= 20; i++) {
            final dateTime = DateTime(2025, 2, 1).add(Duration(days: i - 1));
            await appDatabase.insertTodo(kTodoCompanion.copyWith(
                id: Value(i), deadline: Value(dateTime)));
          }

          expect(await appDatabase.getTodos(), hasLength(20));
        });

        test("limit10", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(limit: 10));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list, hasLength(10));
          expect(list.map((item) => item.id).toList(),
              [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        });

        test("offset_5,limit_10", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(limit: 10, offset: 5));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list, hasLength(10));
          expect(list.map((item) => item.id).toList(),
              [6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
        });

        test("並び替えとlimitの合計", () async {
          final result = await fakeTodoRepository.getAllItem(
              query: TodoTableQuery(
                  limit: 10,
                  offset: 5,
                  orderProperty: "deadline",
                  orderBy: OrderByMethod.desc));

          final list = (result as Ok<List<TodoItem>>).value;
          expect(list, hasLength(10));
          expect(list.map((item) => item.id).toList(),
              [15, 14, 13, 12, 11, 10, 9, 8, 7, 6]);
          expect(list.first.deadline, DateTime(2025, 2, 15));
          expect(list.last.deadline, DateTime(2025, 2, 6));
        });
      });
    });

    group("期日でフィルタリング(getItemsByDeadline)", () {
      setUp(() async {
        final insertTimes = [
          DateTime(2025, 2, 1, 0, 0, 1), //2月1日＋1秒
          DateTime(2025, 2, 2).subtract(Duration(microseconds: 1)), //2月2日-1秒
          DateTime(2025, 2, 3),
          DateTime(2025, 2, 1).subtract(Duration(microseconds: 1)), //2月1日-1秒
        ];
        for (int i = 0; i < insertTimes.length; i++) {
          await appDatabase.insertTodo(kTodoCompanion.copyWith(
              id: Value(i + 2), deadline: Value(insertTimes[i])));
        }
      });

      test("2025-2-1 ~ 2025-2-2でフィルタリング", () async {
        final result = await fakeTodoRepository.getItemsByDeadline(
            first: DateTime(2025, 2, 1), end: DateTime(2025, 2, 2));

        expect((result as Ok<List<TodoItem>>).value, hasLength(3));
        expect(result.value[0].id, 1);
        expect(result.value[1].id, 2);
        expect(result.value[2].id, 3);
      });

      test("2025-2-1 ~ (未指定)でフィルタリング", () async {
        final result = await fakeTodoRepository.getItemsByDeadline(
            first: DateTime(2025, 2, 1));

        expect((result as Ok<List<TodoItem>>).value, hasLength(4));
        expect(result.value[0].id, 1);
        expect(result.value[1].id, 2);
        expect(result.value[2].id, 3);
        expect(result.value[3].id, 4);
      });

      test("(未指定) ~ 2025-2-2でフィルタリング", () async {
        final result = await fakeTodoRepository.getItemsByDeadline(
            end: DateTime(2025, 2, 2));

        expect((result as Ok<List<TodoItem>>).value, hasLength(4));
        expect(result.value[0].id, 1);
        expect(result.value[1].id, 2);
        expect(result.value[2].id, 3);
        expect(result.value[3].id, 5);
      });
    });
  });
}
