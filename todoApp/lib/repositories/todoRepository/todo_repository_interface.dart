import '../../models/todo.dart';

abstract class TodoRepositoryInterface {
  Future<Todo?> create(Todo todo);
  Future<Todo?> findOne(int id);
  Future<List<Todo>> findAll();
  Future<Todo?> update(Todo todo);
  Future<bool> delete(int id);
}
