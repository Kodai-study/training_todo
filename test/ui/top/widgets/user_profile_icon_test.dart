import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/model/user/user.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/ui/top/widgets/user_profile_icon.dart';

import '../../../../testing/app.dart';
import '../../../../testing/mocks/auth_mock.mocks.dart';

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  loadWidget(WidgetTester tester) async {
    await testApp(
        tester,
        ChangeNotifierProvider(
            create: (context) => authRepository, child: UserProfileIcon()));
    await tester.pumpAndSettle();
  }

  testWidgets("Widgetが正しくロードされていること", (tester) async {
    await loadWidget(tester);
    expect(find.byType(UserProfileIcon), findsOneWidget);
  });

  group("未ログイン状態の試験", () {
    testWidgets("未ログインの状態で、未ログインの表示がされていること", (tester) async {
      when(authRepository.isAuthenticated).thenReturn(false);
      await loadWidget(tester);
      expect(find.byIcon(Icons.person_off_sharp), findsOneWidget);
      await tester.tap(find.byType(UserProfileIcon));
      await tester.pumpAndSettle();
      expect(find.text('ログイン'), findsOneWidget);
      expect(find.text('新規登録'), findsOneWidget);
    });
  });

  group("ログイン状態の試験", () {
    testWidgets("ログインの状態で、ログインの表示がされていること", (tester) async {
      when(authRepository.isAuthenticated).thenReturn(true);
      await loadWidget(tester);
      expect(find.byIcon(Icons.person), findsOneWidget);
      await tester.tap(find.byType(UserProfileIcon));
      await tester.pumpAndSettle();
      expect(find.text('設定'), findsOneWidget);
    });

    testWidgets("ユーザ情報が表示されること", (tester) async {
      when(authRepository.isAuthenticated).thenReturn(true);
      when(authRepository.loggedInUser)
          .thenReturn(User(id: 1, name: "name", email: "test@email.com"));
      await loadWidget(tester);

      expect(find.byIcon(Icons.person), findsOneWidget);
      await tester.tap(find.byType(UserProfileIcon));
      await tester.pumpAndSettle();
      expect(find.text('name'), findsOneWidget);
      expect(find.text('test@email.com'), findsOneWidget);
    });
  });
}
