import 'package:flutter/material.dart';
import 'package:training_todo/routing/router.dart';

import './main_development.dart' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dev.main();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
