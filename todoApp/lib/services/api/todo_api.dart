import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoApi {
  TodoApi();

  Future<String?> _getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('todoUrl');
  }

  Future<List<Todo>> getAll() async {
    var url = await _getUrl();
    var response = await http.get(Uri.parse("$url/api/todo"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      return decoded.map<Todo>((map) {
        return Todo.fromMapFormated(map);
      }).toList();
    }
    return [];
  }

  Future<Todo?> getOne(int id) async {
    var url = await _getUrl();
    var response = await http.get(Uri.parse("$url/api/todo/$id"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    return _decodeTodo(response);
  }

  Future<Todo?> post(Todo todo) async {
    var url = await _getUrl();
    var response = await http.post(Uri.parse("${url!}/api/todo"),
        body: json.encode(todo.toMap()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    return _decodeTodo(response);
  }

  Future<Todo?> put(Todo todo) async {
    var url = await _getUrl();
    var response = await http.put(Uri.parse("$url/api/todo"),
        body: json.encode(todo.toMap()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    return _decodeTodo(response);
  }

  Future<bool> delete(int id) async {
    var url = await _getUrl();
    var response = await http.delete(Uri.parse("$url/api/todo/$id"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Todo? _decodeTodo(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return Todo.fromMapFormated(decoded);
    }
    return null;
  }
}
