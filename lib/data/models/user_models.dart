// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String phone;
  final String? token; // Thêm token

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}
