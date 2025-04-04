import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/setup.dart';

class TaskService {
  String baseUrl = '$apiUrl/tasks';
  AuthService authService = AuthService();

  Future<List<Task>> getTasks() async {
    String? token = await getToken();
    if (token == null) {
      return [];
    }
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body)['content'];
        return data.map((json) => Task.fromMap(json)).toList();
      } catch (e) {
        print("error:$e");
        return [];
      }
    } else {
      print('Failed to load tasks');
      return [];
    }
  }

  Future<Task?> createTask(Task task) async {
    String? token = await getToken();
    if (token == null) return null;
    Map<String, dynamic> data = task.toMap();
    data.remove('id');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(data),
    );
    try {
      return Task.fromMap(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<String?> getToken() async {
    String? token = await authService.getTokenLocal();
    return token;
  }

  Future<bool> deleteTask(int taskId) async {
    String? token = await getToken();
    if (token == null) return false;
    final response = await http.delete(
      Uri.parse('$baseUrl/$taskId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.body == "true";
  }

  Future<Task?> updateTask(Task task) async {
    String? token = await getToken();
    if (token == null) return null;
    Map<String, dynamic> data = task.toMap();
    final response = await http.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(data),
    );
    try {
      return Task.fromMap(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  Future<Task?> getTaskById(int id) async {
    String? token = await getToken();
    if (token == null) return null;
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      return Task.fromMap(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}
