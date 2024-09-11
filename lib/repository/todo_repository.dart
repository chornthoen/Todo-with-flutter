import 'package:flutter_demo_app/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const baseUrl = 'https://jsonplaceholder.typicode.com';

class TodoRepository {
  Future<List<Todo>> getTodos({
    required int userId,
    required int page,
  }) async {
    final response =
        await http.get(Uri.parse('$baseUrl/todos?userId=$userId&_page=$page'));
    if (response.statusCode == 200) {
      final todos = convert.jsonDecode(response.body) as List;
      return todos.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
