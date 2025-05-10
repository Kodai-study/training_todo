import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFBEDDE),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
