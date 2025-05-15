import 'package:flutter/cupertino.dart';

class FormFieldBase extends StatelessWidget {
  const FormFieldBase(
      {super.key,
      required this.icon,
      required this.child,
      required this.labelText});

  final IconData icon;
  final Widget child;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 40),
            SizedBox(width: 30, height: 0),
            Text(labelText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
        SizedBox(height: 20, width: 0),
        child,
      ],
    );
  }
}
