import 'package:flutter/cupertino.dart';
import 'package:todoapp/repositories/todoRepository/todo_repository.dart';

import '../models/status.dart';
import '../models/todo.dart';

class HomeNotifier extends ChangeNotifier {
  final todoListController = ValueNotifier<List<Todo>>([]);
  final todoRepository = TodoRepository();
  final statusListController = ValueNotifier<List<Status>>([]);

  HomeNotifier() {
    findAll();
  }

  void loadTodos() {
    for (var i = 0; i <= 10; i++) {
      Todo todo = Todo(
          id: i,
          completionDate: DateTime.now().toString(),
          createdAt: DateTime.now().toString(),
          description: "teste $i",
          status: 0);
      todoListController.value.add(todo);
    }
    todoListController.notifyListeners();
  }

  Future findAll() async {
    var list = await todoRepository.findAll();
    todoListController.value.addAll(list);
    todoListController.notifyListeners();
  }

  Future saveTodo(Todo todo) async {
    var newTodo = await todoRepository.create(todo);
    if (newTodo != null) {
      todoListController.value.add(newTodo);
      todoListController.notifyListeners();
    }
  }

  Future updateTodo(Todo todo) async {
    var uptadedTodo = await todoRepository.update(todo);
    if (uptadedTodo != null) {
      todoListController.value.add(uptadedTodo);
      todoListController.notifyListeners();
    }
  }

  Future deleteTodo(Todo todo) async {
    var result = await todoRepository.delete(todo.id!);
    if (result) {
      todoListController.value.remove(todo);
      todoListController.notifyListeners();
    }
  }
}
