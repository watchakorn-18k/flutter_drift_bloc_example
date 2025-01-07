import 'package:flutter/material.dart';
import 'package:flutter_drift_test/locator.dart';
import 'package:flutter_drift_test/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute:
          AppRouter().onGenerateRoute, // ใช้ AppRouter เพื่อจัดการเส้นทาง
      initialRoute: '/', // หน้าแรกจะเป็น HomePage
    );
  }
}
