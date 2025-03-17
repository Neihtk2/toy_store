class UserModel {
  final int id;
  final String email;
  final String username;
  final int? role;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.role,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      email: json['user']['email'],
      username: json['user']['username'],
      role: json['user']['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}