import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drift_test/domain/repositories/toda_repo.dart';
import 'package:flutter_drift_test/feature/todo/bloc/todo_bloc.dart';
import 'package:flutter_drift_test/feature/todo/widgets/add_todo_dialog.dart';

class TodoPage extends StatelessWidget {
  final TodoRepository todoRepository;

  const TodoPage({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          // ฟังเมื่อมี TodoError
          if (state is TodoError) {
            // แสดง SnackBar หรือ Popup
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TodoLoaded) {
              final items = state.todos;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].title),
                    subtitle: Text(items[index].content),
                  );
                },
              );
            }

            return const Center(child: Text('No todos available.'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // เปิด Dialog เพื่อให้ผู้ใช้กรอกข้อมูล
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) => AddTodoDialog(),
          );

          if (result != null &&
              result.containsKey('title') &&
              result.containsKey('content')) {
            // ส่ง AddTodo event ไปยัง Bloc
            context.read<TodoBloc>().add(AddTodo(
                  title: result['title']!,
                  content: result['content']!,
                ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}