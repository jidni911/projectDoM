import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/models/notices.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/setup.dart';

class NoticeService {
  String baseUrl = '$apiUrl/notice';
  AuthService authService = AuthService();

  Future<List<Notice>> getNotices() async {
    String? token = await authService.getTokenLocal();
    if (token == null) {
      return [];
    }
    final response = await http.get(Uri.parse(baseUrl), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['content'];
      return data.map((json) => Notice.fromJson(json)).toList();
    } else {
      print('Failed to load tasks');
      return [];
    }
  }
}