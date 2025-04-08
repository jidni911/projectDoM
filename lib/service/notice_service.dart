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
      print('Failed to load notices');
      return [];
    }
  }

  Future<Notice?> createNotice(Notice notice) async {
   
    String? token = await authService.getTokenLocal();
    if (token == null) return null;
    Map<String, dynamic> data = notice.toJson();
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
      return Notice.fromJson(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}