import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/models/task.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/screens/task_from_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskFormScreen(task: task),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(task.category),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskProvider.toggleTaskStatus(task.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  _confirmDelete(context, taskProvider, task.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _confirmDelete(
    BuildContext context, TaskProvider taskProvider, String taskId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar eliminacion'),
        content: const Text('¿Estas seguro que deseas eliminar esta tarea?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              taskProvider.deleteTask(taskId);
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          )
        ],
      );
    },
  );
}