class UserSignupDto {
  String username;
  String password;
  String email;
  String fullName;
  String retypePassword;

  UserSignupDto(
    this.username,
    this.password,
    this.email,
    this.fullName,
    this.retypePassword,
  );

  @override
  String toString() {
    return 'UserSignupDto{username: $username, password: $password, email: $email, fullName: $fullName, retypePassword: $retypePassword}';
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'fullName': fullName,
      'retypePassword': retypePassword,
    };
  }
}
