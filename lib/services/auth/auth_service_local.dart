import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../model/user/user.dart';
import '../../util/result.dart';
import '../database/app_database.dart';

/// ローカルのDBに保存されているユーザー情報を元に認証を行うリポジトリクラス
class AuthServiceLocal {
  final AppDatabase _appDatabase;

  AuthServiceLocal(this._appDatabase);

  /// ログイン処理
  ///
  /// [password]ログインに使用するパスワードの平文
  Future<Result<User>> login(
      {required String email, required String password}) async {
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    final user = await (_appDatabase.userTable.select()
          ..where((tbl) =>
              tbl.email.equals(email) &
              tbl.hashedPassword.equals(hashedPassword)))
        .getSingleOrNull();

    if (user == null) {
      return Result.error(Exception("User not found"));
    }

    return Result.ok(User.fromDbObject(user));
  }

  /// サインアウト処理
  Future<Result<void>> signOut() async {
    return Result.ok(null);
  }

  /// ユーザ登録処理
  Future<Result<User>> register(
      {required String name,
      required String email,
      required String password}) async {
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    final userCompanion = UserTableCompanion.insert(
        email: email, name: name, hashedPassword: hashedPassword);
    // ユーザ情報をDBに登録
    final userId = await _appDatabase.insertUser(userCompanion);

    return Result.ok(User(email: email, name: name, id: userId));
  }
}
