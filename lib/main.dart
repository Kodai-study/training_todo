import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_todo/routing/router.dart';

import './main_development.dart' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dev.main();
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _router = router();
  }

  late final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
