import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/services/auth/auth_session_store_local.dart';

import '../../model/user/user.dart';
import '../../services/auth/auth_service_local.dart';
import '../../util/result.dart';

/// ローカルのDBに保存されているユーザー情報を元に認証を行うリポジトリクラス
class AuthRepositoryLocal extends AuthRepository {
  final AuthServiceLocal _authService;
  final AuthSessionStoreLocal _authSessionStore;

  AuthRepositoryLocal(this._authService, this._authSessionStore);

  @override
  bool get isAuthenticated => _authSessionStore.isAuthenticated;

  @override
  User? get loggedInUser => _authSessionStore.loggedInUser;

  @override
  Future<Result<User>> login(
      {required String email, required String password}) async {
    final loginResult =
        await _authService.login(email: email, password: password);
    switch (loginResult) {
      case Ok<User> ok:
        // ログイン成功時、セッションストアにユーザ情報を保存
        try {
          await _authSessionStore.persistSession(ok.value);
        } on Exception catch (e) {
          return Result.error(e);
        }
        return Result.ok(ok.value);
      case Error<User> err:
        // ログイン失敗時はエラーをそのまま返す
        return Result.error(err.error);
    }
  }

  @override
  Future<Result<User>> register(
      {required String name,
      required String email,
      required String password}) async {
    final registerResult = await _authService.register(
        name: name, email: email, password: password);
    switch (registerResult) {
      case Ok<User> ok:
        // 登録成功時、セッションストアにユーザ情報を保存
        _authSessionStore.persistSession(ok.value);
        return Result.ok(ok.value);
      case Error<User> err:
        // 登録失敗時はエラーをそのまま返す
        return Result.error(err.error);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    // セッションストアからユーザ情報を削除
    try {
      final signOutResult = await _authService.signOut();
      if (signOutResult is Error) {
        return Result.error(signOutResult.error);
      }
      _authSessionStore.signOut();
    } on Exception catch (e) {
      return Result.error(e);
    }
    return Result.ok(null);
  }
}
