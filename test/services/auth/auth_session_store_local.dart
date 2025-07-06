import 'package:flutter_test/flutter_test.dart';
import 'package:training_todo/model/user/user.dart';
import 'package:training_todo/services/auth/auth_session_store_local.dart';

void main() {
  late AuthSessionStoreLocal sessionStore;

  setUp(() {
    sessionStore = AuthSessionStoreLocal();
  });

  test('ユーザ情報の登録、保持が正常におこなえること', () async {
    final storedUser =
        User(id: 1, name: 'Test User', email: 'test@example.com');

    sessionStore.persistSession(storedUser);

    expect(sessionStore.isAuthenticated, isTrue);
    expect(sessionStore.loggedInUser, storedUser);
  });
}
