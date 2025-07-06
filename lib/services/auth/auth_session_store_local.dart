import 'package:flutter/cupertino.dart';

import '../../model/user/user.dart';

class AuthSessionStoreLocal extends ChangeNotifier {
  User? _currentUser;

  bool get isAuthenticated => _currentUser != null;

  User? get loggedInUser => _currentUser;

  Future<void> persistSession(User user) async {
    _currentUser = user;
    notifyListeners();
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }
}
