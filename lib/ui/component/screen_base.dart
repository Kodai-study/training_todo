import 'package:flutter/material.dart';

import 'header.dart';

class ScreenBase extends StatelessWidget {
  final Widget body;

  const ScreenBase({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Header(title: "ページ"), body: body);
  }
}
