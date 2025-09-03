import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int userId;
  String fullName;
  String phone;
  String email;
  String password;
  int roleId;

  User({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    fullName: json["full_name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "full_name": fullName,
    "phone": phone,
    "email": email,
    "password": password,
    "role_id": roleId,
  };
}
