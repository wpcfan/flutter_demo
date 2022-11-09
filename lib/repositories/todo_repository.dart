import 'package:demo/config.dart';
import 'package:demo/models/todo.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  final Dio dio;
  final String _url = 'jsonplaceholder.typicode.com';

  TodoRepository(this.dio);

  Future<List<Todo>> getTodos([int startIndex = 0]) async {
    final response = await dio.getUri(Uri.https(_url, '/todos', {
      '_start': '$startIndex',
      '_limit': '$pageSize',
    }));
    if (response.statusCode == 200) {
      final json = response.data as List;
      final todos = json.map((e) => Todo.fromJson(e)).toList();
      return todos;
    }
    throw Exception('Failed to load todos');
  }

  Future<Todo> createTodo(Todo todo) async {
    final response =
        await dio.postUri(Uri.https(_url, '/todos'), data: todo.toJson());
    if (response.statusCode == 201) {
      final json = response.data;
      final todo = Todo.fromJson(json);
      return todo;
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<Todo> updateTodoById(int id, Todo todo) async {
    final response = await dio.putUri(
      Uri.https(_url, '/todos/$id'),
      data: todo.toJson(),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      final todo = Todo.fromJson(json);
      return todo;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodoById(int id) async {
    final response = await dio.deleteUri(Uri.https(_url, '/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
