import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolistapp/models/task.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasksBox');
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks {
    final allTasks = _taskBox.values.toList();
    switch (_filter) {
      case TaskFilter.completed:
        return allTasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return allTasks.where((task) => !task.isCompleted).toList();
      default:
        return allTasks;
    }
  }

  TaskFilter get filter => _filter;

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(String title, String category) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      category: category,
    );
    _taskBox.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final key = _taskBox.keys.firstWhere(
      (k) => _taskBox.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      final task = _taskBox.get(key)!;
      task.isCompleted = !task.isCompleted;
      _taskBox.put(key, task); // actualizar
      notifyListeners();
    }
  }

  void editTask(String id, String newTitle, String newCategory) {
    final key = _taskBox.keys.firstWhere(
      (k) => _taskBox.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      final oldTask = _taskBox.get(key)!;
      final updatedTask = Task(
        id: oldTask.id,
        title: newTitle,
        category: newCategory,
        isCompleted: oldTask.isCompleted,
      );
      _taskBox.put(key, updatedTask);
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    final key = _taskBox.keys.firstWhere(
      (k) => _taskBox.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      _taskBox.delete(key);
      notifyListeners();
    }
  }
}
