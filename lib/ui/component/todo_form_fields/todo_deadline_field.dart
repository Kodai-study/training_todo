import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_todo/ui/component/todo_form_fields/form_field_base.dart';

class TodoDeadlineField extends StatelessWidget {
  TodoDeadlineField(
      {super.key, required this.controller, DateTime? initialValue}) {
    initialValue = initialValue ?? DateTime.now();
  }

  final TextEditingController controller;
  late final DateTime initialValue;
  final _dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return FormFieldBase(
      labelText: "Description",
      icon: Icons.calendar_month,

      // 日付を入力するためのフィールド
      // DatePickerを使用する
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              size: 30,
            ),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              controller.text = _formatDate(picked);
              // 選択した日付を使って何か処理を追加してください
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    return _dateFormat.format(date);
  }
}
