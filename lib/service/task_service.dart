import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/setup.dart';

class TaskService {
  String baseUrl = '$apiUrl/tasks';
  AuthService authService = AuthService();

  Future<List<Task>> getTasks() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['content'];
      return data.map((json) => Task.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(Task task) async {
    String token = await getToken();
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
    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  Future<String> getToken() async {
    String token = await authService.getTokenLocal();
    return token;
  }
}
