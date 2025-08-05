import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/screens/task_from_screen.dart';
import 'package:todolistapp/screens/task_list_screen.dart';
import 'package:todolistapp/theme/app_theme.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => TaskListScreen(),
        '/add-task': (context) => TaskFormScreen(),
      },
    );
  }
}
