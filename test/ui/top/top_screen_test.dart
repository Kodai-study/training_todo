import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/ui/top/top_screen.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/ui/top/widgets/todo_list.dart';
import 'package:training_todo/util/result.dart';

import '../../../testing/app.dart';
import '../../../testing/mocks/app_database_mock.mocks.dart';
import '../../../testing/mocks/auth_mock.mocks.dart' show MockAuthRepository;
import '../../../testing/models/todo.dart';

void main() {
  late TodoRepository todoRepository;

  setUp(() {
    todoRepository = MockTodoRepository();
  });

  loadWidget(WidgetTester tester) async {
    await testApp(
      tester,
      MultiProvider(providers: [
        ChangeNotifierProvider<TopViewmodel>(
            create: (context) => TopViewmodel(todoRepository)),
        ChangeNotifierProvider<AuthRepository>(
            create: (context) => MockAuthRepository()),
      ], child: TopScreen()),
    );
  }

  group("Todoリストの表示テスト", () {
    testWidgets("ウィジットが正しくロードできること", (tester) async {
      await loadWidget(tester);
      expect(find.byType(TopScreen), findsOneWidget);
      expect(find.byType(TodoList), findsOneWidget);
    });

    testWidgets("初期で未完了リストが表示される", (tester) async {
      setListAnswer(todoRepository,
          completedList: ["完了済みタスク1", "完了済みタスク2"],
          inCompletedList: ["未完了タスク1"]);

      await loadWidget(tester);
      await tester.pumpAndSettle();

      expect(find.text("未完了タスク1"), findsOneWidget);
      expect(find.text("完了済みタスク1"), findsNothing);
    });

    testWidgets("タブをクリックすると、未完了→完了済み→未完了 とリストを切り替えれること", (tester) async {
      setListAnswer(todoRepository,
          completedList: ["完了済みタスク1", "完了済みタスク2"],
          inCompletedList: ["未完了タスク1"]);

      await loadWidget(tester);
      await tester.pumpAndSettle();

      expect(find.text("未完了タスク1"), findsOneWidget);
      await tester.tap(find.text("完了済み"));
      await tester.pumpAndSettle();

      expect(find.text("完了済みタスク1"), findsOneWidget);
      expect(find.text("完了済みタスク2"), findsOneWidget);

      await tester.tap(find.text("未完了"));
      await tester.pumpAndSettle();
      expect(find.text("未完了タスク1"), findsOneWidget);
    });
  });
}

void setListAnswer(TodoRepository mockRepository,
    {List<String>? completedList, List<String>? inCompletedList}) {
  if (completedList != null) {
    final list = createCompletedListByTitles(completedList);
    when(mockRepository.getItemsByCompletionStatus(true,
            query: anyNamed('query')))
        .thenAnswer((_) async => Result.ok(list));
  }

  if (inCompletedList != null) {
    final list = createUnCompletedListByTitles(inCompletedList);
    when(mockRepository.getItemsByCompletionStatus(false,
            query: anyNamed('query')))
        .thenAnswer((_) async => Result.ok(list));
  }
}
