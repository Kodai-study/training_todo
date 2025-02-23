import 'package:flutter/material.dart';

import 'header.dart';

class ScreenBase extends StatelessWidget {
  final Widget body;
  final String title;

  const ScreenBase({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Header(title: title), body: body);
  }
}
