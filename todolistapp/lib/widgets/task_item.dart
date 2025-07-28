import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/models/task.dart';
import 'package:todolistapp/providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Card(
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.category),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            taskProvider.toggleTaskStatus(task.id);
          },
        ),
        onTap: () {
          // Navigate to task details or edit screen
        },
      ),
    );
  }
}
