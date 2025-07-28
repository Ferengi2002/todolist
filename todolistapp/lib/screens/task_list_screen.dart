import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (contex, index) {
          final task = taskProvider.tasks[index];
          return TaskItem(
            task: task,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}