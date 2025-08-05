import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/models/task.dart';
import 'package:todolistapp/providers/task_provider.dart';
import 'package:todolistapp/theme/base_screen.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _isEditing = true;
      _titleController = TextEditingController(text: widget.task!.title);
      _categoryController = TextEditingController(text: widget.task!.category);
    } else {
      _titleController = TextEditingController();
      _categoryController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return BaseScreen(
      title: _isEditing ? 'Editar Tarea' : 'Añadir Tarea',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa un título' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingresa una categoría'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_isEditing) {
                      taskProvider.editTask(
                        widget.task!.id,
                        _titleController.text,
                        _categoryController.text,
                      );
                    } else {
                      taskProvider.addTask(
                        _titleController.text,
                        _categoryController.text,
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(_isEditing ? 'Guardar Cambios' : 'Añadir Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
