import 'package:flutter/cupertino.dart';

import '../../model/user/user.dart';
import '../../util/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  bool get isAuthenticated;

  User? get loggedInUser;

  /// Get current user
  Future<Result<User>> login({required String email, required String password});

  /// Sign out
  Future<Result<void>> signOut();

  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  });
}
