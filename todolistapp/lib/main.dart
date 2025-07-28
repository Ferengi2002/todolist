import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/providers/task_provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GradientHomePage(),
    );
  }
}

class GradientHomePage extends StatelessWidget {
  const GradientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con degradado
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueGrey],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('To-Do List'),
          ),
        ),
      ),
      // Fondo con degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlueAccent, Colors.blueGrey.shade700 ],
          ),
        ),
        child: Center(
          child: Text(
            'Bienvenido a la Lista de Tareas',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
