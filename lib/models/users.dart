class User {
  int? id;
  String? fullName;
  String? username;
  String? email;
  String? password;
  int? phone;
  String? address;
  String? imageUrl;

  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, username: $username, email: $email, password: $password, phone: $phone, address: $address, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  static fromJson(json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
