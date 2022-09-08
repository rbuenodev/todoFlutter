import 'package:flutter/cupertino.dart';
import 'package:todoapp/repositories/todoRepository/todo_repository.dart';

import '../models/status.dart';
import '../models/todo.dart';

class TodoNotifier extends ChangeNotifier {
  final todoRepository = TodoRepository();
  final statusListController = ValueNotifier<List<Status>>([]);

  TodoNotifier() {
    _loadStatus();
  }

  void _loadStatus() {
    List<Status> statusList = [
      Status(id: 0, description: "A Realizar"),
      Status(id: 1, description: "Realizado"),
      Status(id: 2, description: "Cancelado"),
      Status(id: 3, description: "Aguardando Avaliação"),
    ];
    statusListController.value.addAll(statusList);
    statusListController.notifyListeners();
  }

  Future<Todo?> saveTodo(Todo todo) async {
    try {
      todo.validate();
    } catch (e) {
      rethrow;
    }

    if (todo.id != 0) {
      return await _updateTodo(todo);
    }
    return await _createTodo(todo);
  }

  Future<Todo?> _createTodo(Todo todo) async {
    var newTodo = await todoRepository.create(todo);
    return newTodo;
  }

  Future<Todo?> _updateTodo(Todo todo) async {
    return await todoRepository.update(todo);
  }
}
