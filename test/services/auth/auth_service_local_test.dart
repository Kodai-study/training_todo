import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_todo/model/user/user.dart';
import 'package:training_todo/services/auth/auth_service_local.dart';
import 'package:training_todo/services/database/app_database.dart';
import 'package:training_todo/util/result.dart';

void main() {
  group("実際にDBに書き込む試験", () {
    late AppDatabase appDatabase;
    late AuthServiceLocal repository;
    final testUser = User(id: 1, name: 'Test User', email: 'test@example.com');
    final password = 'password';

    setUp(() {
      appDatabase = AppDatabase(NativeDatabase.memory());
      repository = AuthServiceLocal(appDatabase);
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('ユーザ登録に成功すること', () async {
      // ユーザ登録
      final result = await repository.register(
        name: testUser.name,
        email: testUser.email,
        password: password,
      );
      expect(result, isA<Ok>());
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
      expect(loggedInUser, testUser);
    });


    test('ユーザ登録後、間違ったパスワードでログインが失敗すること', () async {
      await repository.register(
        name: testUser.name,
        email: testUser.email,
        password: password,
      );

      // 登録したユーザでログイン
      final loginResult = await repository.login(
        email: testUser.email,
        password: "wrong_password",
      );

      // ログインが正しく行えたこと
      expect(loginResult, isA<Error>());
    });
  });
}
