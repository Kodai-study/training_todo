import 'package:flutter/material.dart';
import 'package:training_todo/ui/component/screen_base.dart';

class TopPage extends StatelessWidget {
   const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBase(body: Text("トップ画面"), title: "title");
  }
}
