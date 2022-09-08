import 'package:todoapp/models/todo.dart';
import 'package:todoapp/repositories/todoRepository/todo_repository_interface.dart';
import 'package:todoapp/services/api/todo_api.dart';

class TodoRepository implements TodoRepositoryInterface {
  final _api = TodoApi();

  @override
  Future<bool> delete(int id) async {
    return await _api.delete(id);
  }

  @override
  Future<List<Todo>> findAll() async {
    return await _api.getAll();
  }

  @override
  Future<Todo?> findOne(int id) async {
    return await _api.getOne(id);
  }

  @override
  Future<Todo?> update(Todo todo) async {
    return await _api.put(todo);
  }

  @override
  Future<Todo?> create(Todo todo) async {
    return await _api.post(todo);
  }
}
