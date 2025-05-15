import 'package:flutter/material.dart';
import 'package:training_todo/ui/component/todo_form_fields/form_field_base.dart';

/// タスク名を入力するためのフィールド
class TodoTitleField extends StatelessWidget {
  /// [initialValue] : 初期値
  ///
  /// [controller] : コントローラ
  TodoTitleField(
      {super.key, String initialValue = "", required this.controller}) {
    controller.text = initialValue;
  }

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFieldBase(
      labelText: "タスク名",
      icon: Icons.assignment,
      child: TextFormField(
        key: const Key("todo_title_field"),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEEEEEE),
          labelText: "Title",
          hintText: "Enter title",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Please enter a title" : null,
      ),
    );
  }
}
