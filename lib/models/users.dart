class User {
  int? id;
  String name;
  String? email;
  String? password;
  int? phone;
  String? address;
  String? imageUrl;

  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });
}
