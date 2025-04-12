import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/models/books.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/setup.dart';

class BookService {
  String baseUrl = '$apiUrl/notice';
  AuthService authService = AuthService();

  Future<List<Book>> getBooks() async {
    String? token = await authService.getTokenLocal();
    if (token == null) {
      return [];
    }
    final response = await http
        .get(Uri.parse(baseUrl), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['content'];
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      print('Failed to load notices');
      return [];
    }
  }
}
