import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/models/task.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/screens/task_from_screen.dart';
import 'package:todolistapp/screens/task_list_screen.dart';
import 'package:todolistapp/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🧠 Inicializa Hive y registra el adaptador
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  // Abre la caja donde se guardarán las tareas
  await Hive.openBox<Task>('tasksBox');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => const TaskListScreen(),
        '/add-task': (context) => const TaskFormScreen(),
      },
    );
  }
}
