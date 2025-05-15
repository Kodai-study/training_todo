import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/ui/add_todo/view_models/add_todo_view_model.dart';
import 'package:training_todo/ui/component/todo_form_fields/todo_description_field.dart';

import '../component/todo_form_fields/todo_deadline_field.dart';
import '../component/todo_form_fields/todo_title_field.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});

  final _titleTextController = TextEditingController()..text = "";
  final _descriptionTextController = TextEditingController();
  final _deadlineTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddTodoViewModel>();

    void addNewTask() {
      if (_formKey.currentState!.validate()) {
        viewModel.createNewTask.execute(viewModel.createTodoItem(
            _titleTextController.text,
            _descriptionTextController.text,
            _deadlineTextController.text));
        context.pop();
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("タスクを追加"),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoTitleField(controller: _titleTextController),
                  const SizedBox(height: 50),
                  TodoDeadlineField(controller: _deadlineTextController),
                  const SizedBox(height: 50),
                  TodoDescriptionField(controller: _descriptionTextController),
                  const SizedBox(height: 50),
                  _buildAddButton(addNewTask),
                ],
              )),
        ));
  }

  Widget _buildAddButton(VoidCallback onSubmit) {
    //   丸角のボタン。色は緑色
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.green,
      ),
      onPressed: onSubmit,
      child: Text(
        "追加",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
