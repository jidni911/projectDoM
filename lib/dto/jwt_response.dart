import 'package:project_dom/models/users.dart';

class JwtResponse {
  User user;
  String jwtToken;

  JwtResponse({required this.user, required this.jwtToken});

  // Factory constructor to create an instance from JSON
  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      jwtToken: json['jwtToken'],
    );
  }
}
