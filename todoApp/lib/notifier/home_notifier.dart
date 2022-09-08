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
    todoListController.value.addAll([]);
    todoListController.value.addAll(list);
    todoListController.notifyListeners();
  }

  Future addTodoOnList(Todo newTodo) async {
    List<Todo> list = [];
    list.addAll(todoListController.value);
    list.retainWhere((todo) => (todo.id == newTodo.id));
    if (list.isEmpty) {
      todoListController.value.add(newTodo);
    } else {
      todoListController.value.remove(list.first);
      todoListController.value.add(newTodo);
    }
    todoListController.notifyListeners();
  }
}
