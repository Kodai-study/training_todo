import 'package:training_todo/repositories/auth/auth_repository.dart';

import '../../model/user/user.dart';
import '../../util/result.dart';

class AuthRepositoryDemo extends AuthRepository {
  @override
  bool get isAuthenticated => true;

  final User _loggedInUser =
      User(id: 1, name: "sample name", email: "sample@email.com");

  @override
  Future<Result<User>> login(
      {required String email, required String password}) {
    return Future.value(Result.ok(_loggedInUser));
  }

  @override
  Future<Result<void>> signOut() {
    return Future.value(Result.ok(null));
  }

  @override
  // TODO: implement loggedInUser
  User? get loggedInUser => _loggedInUser;
}
