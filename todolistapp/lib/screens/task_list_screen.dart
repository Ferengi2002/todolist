import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/theme/base_screen.dart';
import 'package:todolistapp/widgets/elevation_button.dart';
import 'package:todolistapp/widgets/task_item.dart';


class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return BaseScreen(
      title: 'Lista de Tareas',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task');
        },
        label: const Text('Añadir tarea'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                FilterButton(
                  label: 'Todas',
                  isSelected: taskProvider.filter == TaskFilter.all,
                  onPressed: () => taskProvider.setFilter(TaskFilter.all),
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'Completadas',
                  isSelected: taskProvider.filter == TaskFilter.completed,
                  onPressed: () => taskProvider.setFilter(TaskFilter.completed),
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'Pendientes',
                  isSelected: taskProvider.filter == TaskFilter.pending,
                  onPressed: () => taskProvider.setFilter(TaskFilter.pending),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskItem(task: task);
              },
            ),
          )
        ],
      ),
    );
  }
}
