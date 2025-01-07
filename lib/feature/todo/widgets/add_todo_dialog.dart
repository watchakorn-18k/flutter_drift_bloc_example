import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drift_test/feature/todo/bloc/todo_bloc.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // ปิด Dialog
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final title = _titleController.text;
            final content = _contentController.text;

            if (title.isNotEmpty && content.isNotEmpty) {
              // ส่ง AddTodo event ไปยัง Bloc
              context
                  .read<TodoBloc>()
                  .add(AddTodo(title: title, content: content));

              // ปิด Dialog
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
