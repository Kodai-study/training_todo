import 'dart:async';

import 'package:flutter/cupertino.dart';

extension ChangeNotifierTestHelper on ChangeNotifier {
  Future awaitNotifyListeners({
    required Function block,
    int expectedCount = 1,
    int seconds = 2,
  }) async {
    final completer = Completer();
    var notifiedCount = 0;
    addListener(() {
      if (++notifiedCount == expectedCount) {
        completer.complete();
      }
    });
    block();
    return completer.future.timeout(Duration(seconds: seconds));
  }
}