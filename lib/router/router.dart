import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drift_test/domain/repositories/toda_repo.dart';
import 'package:flutter_drift_test/feature/todo/bloc/todo_bloc.dart';
import 'package:flutter_drift_test/feature/todo/pages/todo_page.dart';
import 'package:flutter_drift_test/feature/home/pages/home_page.dart';
import 'package:flutter_drift_test/locator.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final todoRepository = locator<TodoRepository>();

    final uri = Uri.parse(settings.name!);

    // Home
    if (uri.path == '/') {
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
      );
    }

    if (uri.path == '/todo') {
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
            ),

            //??
            // BlocProvider(
            //   create: (context) =>
            //       UserBloc(userRepository: userRepository)..add(LoadUsers()),
            // ),
            //??
          ],
          child: TodoPage(todoRepository: todoRepository),
        ),
      );
    }

    // เส้นทางไม่พบ
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }
}
