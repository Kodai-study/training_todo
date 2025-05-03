import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/ui/top/view_models/top_viewmodel.dart';
import 'package:training_todo/ui/top/widgets/todo_list.dart';
import 'package:training_todo/ui/top/widgets/todo_list_tile.dart';
import 'package:training_todo/util/result.dart';

import '../../../../testing/app.dart';
import '../../../../testing/mocks/app_database_mock.mocks.dart';
import '../../../../testing/models/todo.dart';

void main() {
  late TodoRepository todoRepository;
  late TopViewmodel topViewmodel;

  loadWidget(WidgetTester tester, bool isCompleted) async {
    await testApp(
        tester,
        ChangeNotifierProvider(
            create: (context) => topViewmodel,
            child: TodoList(isCompleted: isCompleted)));
  }

  setUp(() {
    todoRepository = MockTodoRepository();
    topViewmodel = TopViewmodel(todoRepository);
  });

  testWidgets("正しく表示されること", (tester) async {
    await loadWidget(tester, true);

    expect(find.byType(TodoList), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TodoListTile), findsNothing);
  });

  testWidgets("リポジトリから完了済みが3件返される場合、完了済みリストが3件表示されること", (tester) async {
    await loadWidget(tester, true);

    when(todoRepository.getItemsByCompletionStatus(true,
            query: anyNamed("query")))
        .thenAnswer((_) async => Result.ok(createDefaultCompletedTodoList(3)));
    await topViewmodel.loadList.execute();
    await tester.pumpAndSettle();

    expect(find.byType(TodoListTile), findsNWidgets(3));

    testTodoListByTexts(tester, ["title1", "title2", "title3"]);
  });

  testWidgets("リポジトリから完了済みが3件返される場合、未完了リストに何も表示されない", (tester) async {
    await loadWidget(tester, false);

    when(todoRepository.getItemsByCompletionStatus(true,
            query: anyNamed("query")))
        .thenAnswer((_) async => Result.ok(createDefaultCompletedTodoList(2)));
    await topViewmodel.loadList.execute();
    await tester.pumpAndSettle();

    expect(find.byType(TodoListTile), findsNothing);
  });

  testWidgets("リポジトリから100件返される場合、スクロールして全て表示できること", (tester) async {
    await loadWidget(tester, true);

    when(todoRepository.getItemsByCompletionStatus(true,
            query: anyNamed("query")))
        .thenAnswer(
            (_) async => Result.ok(createDefaultCompletedTodoList(100)));
    await topViewmodel.loadList.execute();
    await tester.pumpAndSettle();
    // スクロールして最後のアイテムを表示
    await tester.drag(find.byType(ListView), const Offset(0, -5000));
    await tester.pumpAndSettle();

    expect(find.text("title100"), findsOneWidget);
  });
}

void testTodoListByTexts(WidgetTester tester, List<String> titles) {
  final todoListTiles =
      tester.widgetList<TodoListTile>(find.byType(TodoListTile));
  int listIndex = 0;

  for (TodoListTile todoTile in todoListTiles) {
    final finder = find.descendant(
      of: find.byWidget(todoTile),
      matching: find.text(titles[listIndex]),
    );
    expect(finder, findsOneWidget);
    listIndex++;
  }
}
