import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter_drift_test/domain/datasource/app_datebase.dart';
import 'package:flutter_drift_test/domain/repositories/toda_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoRepository.getAllTodoItems();
        if (kDebugMode) {
          print('Loaded todos: $todos');
        }
        emit(TodoLoaded(todos));
      } catch (e) {
        if (kDebugMode) {
          print('Failed to load todos: $e');
        }
        emit(TodoError('Failed to load todos.'));
      }
    });

    on<AddTodo>((event, emit) async {
      emit(TodoLoading());

      try {
        // เพิ่ม Todo ใหม่
        await todoRepository.addTodoItem(event.title, event.content);

        // โหลดข้อมูลใหม่หลังจากเพิ่ม
        final todos = await todoRepository.getAllTodoItems();
        emit(TodoLoaded(todos));
      } catch (e) {
        // ส่งข้อผิดพลาดไปที่ state
        emit(TodoError('Failed to add todo: ${e.toString()}'));
      }
    });
  }
}
