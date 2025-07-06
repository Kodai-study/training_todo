import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_todo/model/user/user.dart';
import 'package:training_todo/repositories/auth/auth_repository_local.dart';
import 'package:training_todo/services/auth/auth_service_local.dart';
import 'package:training_todo/services/auth/auth_session_store_local.dart';
import 'package:training_todo/services/database/app_database.dart';
import 'package:training_todo/util/result.dart';

import '../../../testing/mocks/auth_mock.mocks.dart';

void main() {
  final testUser = User(id: 1, name: 'Test User', email: 'test@example.com');
  provideDummy<Result<User>>(Result.ok(testUser));

  group("認証処理でモックを使った試験", () {
    late AuthRepositoryLocal repository;
    late MockAuthServiceLocal mockAuthService;
    late AuthSessionStoreLocal authSessionStoreLocal;

    setUp(() {
      mockAuthService = MockAuthServiceLocal();
      authSessionStoreLocal = AuthSessionStoreLocal();
      repository = AuthRepositoryLocal(mockAuthService, authSessionStoreLocal);
    });

    test('ログイン成功時', () async {
      when(mockAuthService.login(
              email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => Result.ok(testUser));
      final loginResult =
          await repository.login(email: testUser.email, password: 'password');

      expect(loginResult, isA<Ok<User>>());
      expect((loginResult as Ok<User>).value, equals(testUser));
      expect(authSessionStoreLocal.isAuthenticated, isTrue);
    });

    test('ログイン失敗時', () async {
      when(mockAuthService.login(
              email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => Result.error(Exception("Login failed")));

      final loginResult =
          await repository.login(email: testUser.email, password: 'password');

      expect(loginResult, isA<Error<User>>());
      expect((loginResult as Error<User>).error.toString(),
          equals("Exception: Login failed"));
      expect(authSessionStoreLocal.isAuthenticated, isFalse);
    });
  });

  group("認証状態保持でモックを使った試験", () {
    late AuthRepositoryLocal repository;
    late MockAuthServiceLocal mockAuthService;
    late MockAuthSessionStoreLocal mockAuthSessionStoreLocal;

    setUp(() {
      mockAuthService = MockAuthServiceLocal();
      mockAuthSessionStoreLocal = MockAuthSessionStoreLocal();
      repository =
          AuthRepositoryLocal(mockAuthService, mockAuthSessionStoreLocal);
    });

    test("通常状態でOKになる", () async {
      final result = await repository.login(
        email: testUser.email,
        password: 'password',
      );

      expect(result, isA<Ok<User>>());
    });

    test('認証情報保存の失敗時にエラーになる', () async {
      when(mockAuthSessionStoreLocal.persistSession(any))
          .thenThrow(Exception("Failed to persist session"));

      final loginResult =
          await repository.login(email: testUser.email, password: 'password');

      expect(loginResult, isA<Error<User>>());
    });
  });

  group("実際にDBに書き込む試験", () {
    late AppDatabase appDatabase;
    late AuthRepositoryLocal repository;
    late AuthServiceLocal authService;
    late AuthSessionStoreLocal authSessionStoreLocal;
    final password = 'password';

    setUp(() {
      appDatabase = AppDatabase(NativeDatabase.memory());
      authService = AuthServiceLocal(appDatabase);
      authSessionStoreLocal = AuthSessionStoreLocal();
      repository = AuthRepositoryLocal(authService, authSessionStoreLocal);
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('ユーザ登録に成功すること', () async {
      final result = await repository.register(
        name: testUser.name,
        email: testUser.email,
        password: password,
      );

      expect(result, isA<Ok>());
      expect(repository.isAuthenticated, isTrue); // テスト用に認証状態をセット
    });

    test('ユーザ登録後、そのユーザ情報でログインができること', () async {
      await repository.register(
        name: testUser.name,
        email: testUser.email,
        password: password,
      );

      // 登録したユーザでログイン
      final loginResult = await repository.login(
        email: testUser.email,
        password: password,
      );

      // ログインが正しく行えたこと
      expect(loginResult, isA<Ok>());
      final loggedInUser = (loginResult as Ok<User>).value;
      // ログイン時に取得されたユーザ情報が正しいこと
      expect(loggedInUser.name, 'Test User');
      expect(loggedInUser.email, 'test@example.com');

      // ログイン状態と、ログイン中のユーザ情報が正しいこと
      expect(repository.isAuthenticated, isTrue);
      expect(repository.loggedInUser, equals(testUser));
    });
  });
}
