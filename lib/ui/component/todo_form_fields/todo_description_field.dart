import 'package:flutter/material.dart';
import 'package:training_todo/ui/component/todo_form_fields/form_field_base.dart';

/// タスクのメモを入力するためのフィールド
class TodoDescriptionField extends StatelessWidget {

  /// [initialValue] : 初期値
  ///
  /// [controller] : コントローラ
  const TodoDescriptionField(
      {super.key, this.initialValue = "", required this.controller});

  final String initialValue;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormFieldBase(
      labelText: "メモ",
      icon: Icons.edit_note,
      child: TextFormField(
        initialValue: initialValue,
        maxLines: 5,
        // 背景を塗りつぶしにする。 角は丸くする
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEEEEEE),
          // 外枠を黒でつける
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
          labelText: "Title",
          hintText: "Enter title",
        ),
      ),
    );
  }
}
