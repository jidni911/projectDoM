import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_dom/dto/jwt_response.dart';
import 'package:project_dom/dto/signup_dto.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = '$apiUrl/auth';
  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return '';
      }
      setInfoLocal(response.body);
      User user = await getProfileLocal();
      return user.toString();
    } else {
      return response.body;
    }
  }

  Future<String> echo(String message) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/echo?param=$message'));
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> isEmailUnique(String email) async {
    final response =
        await http.get(Uri.parse('$baseUrl/emailAvailable?email=$email'));
    // print(response.body);
    return response.body == 'true';
  }

  Future<bool> isUsernameUnique(String username) async {
    final response = await http
        .get(Uri.parse('$baseUrl/usernameAvailable?username=$username'));
    return response.body == 'true';
  }

  Future<String> signup(UserSignupDto userInfo) async {
    final response = http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userInfo.toJson()),
    );
    return response.then((value) => value.body);
  }

  Future<String> logout() async {
    final response = await http.get(Uri.parse('$baseUrl/logout'));
    await removeInfoLocal();
    return response.body;
  }

  Future<String> refresh() async {
    final response = await http.get(Uri.parse('$baseUrl/refresh'));
    return response.body;
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    final response = await http.put(
      Uri.parse('$baseUrl/password'),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}),
    );
    return response.body;
  }

  Future<String> resetPassword(String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/resetPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.body;
  }

  Future<String> forgotPassword(String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/forgotPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.body;
  }

  Future<String> changeEmail(String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.body;
  }

  Future<String> changeUsername(String username) async {
    final response = await http.put(
      Uri.parse('$baseUrl/username'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );
    return response.body;
  }

  Future<String> changeFullName(String fullName) async {
    final response = await http.put(
      Uri.parse('$baseUrl/fullName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullName': fullName}),
    );
    return response.body;
  }

  Future<String> changeAvatar(String avatar) async {
    final response = await http.put(
      Uri.parse('$baseUrl/avatar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'avatar': avatar}),
    );
    return response.body;
  }

  Future<void> setInfoLocal(String info) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', info);
  }

  Future<String> getInfoLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userInfo') ?? '';
  }

  Future<void> removeInfoLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userInfo');
  }

  Future<User> getProfileLocal() async {
    String value = await getInfoLocal(); // Wait for local data retrieval
    if (value.isEmpty) return User();
    Map<String, dynamic> jsonResponse = jsonDecode(value);
    JwtResponse jwtResponse = JwtResponse.fromJson(jsonResponse);
    return jwtResponse.user; // Correctly return the User object
  }

  Future<String> getTokenLocal() async {
    String value = await getInfoLocal(); // Wait for local data retrieval
    if (value.isEmpty) return '';
    Map<String, dynamic> jsonResponse = jsonDecode(value);
    JwtResponse jwtResponse = JwtResponse.fromJson(jsonResponse);
    return jwtResponse.jwtToken; // Correctly return the User object
  }
}
