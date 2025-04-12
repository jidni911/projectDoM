import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/models/books.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/setup.dart';

class BookService {
  String baseUrl = '$apiUrl/books';
  AuthService authService = AuthService();

  Future<List<Book>> getBooks() async {
    String? token = await authService.getTokenLocal();
    if (token == null) {
      return [];
    }
    final response = await http
        .get(Uri.parse(baseUrl), headers: {'Authorization': 'Bearer $token'});
        // print(response.body);
        // return [];
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['content'];
      // print(data);
      // return [];
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      print('Failed to load notices');
      return [];
    }
  }
  Future<Book?> createBook(Book book) async {
    String? token = await authService.getTokenLocal();
    if (token == null) return null;
    Map<String, dynamic> data = book.toJson();
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
      return Book.fromJson(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
