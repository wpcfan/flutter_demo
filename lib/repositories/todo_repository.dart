import 'dart:convert';

import 'package:demo/models/todo_model.dart';
import 'package:http/http.dart';

class TodoRepository {
  final String _url = 'jsonplaceholder.typicode.com';

  Future<List<Todo>> getTodos() async {
    final response = await get(Uri.https(_url, '/todos'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json.map((e) => Todo.fromJson(e)).toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final response = await post(Uri.https(_url, '/todos'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(todo.toJson()));
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final todo = Todo.fromJson(json);
      return todo;
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<Todo> updateTodoById(int id, Todo todo) async {
    final response = await put(Uri.https(_url, '/todos/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(todo.toJson()));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final todo = Todo.fromJson(json);
      return todo;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodoById(int id) async {
    final response = await delete(Uri.https(_url, '/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
