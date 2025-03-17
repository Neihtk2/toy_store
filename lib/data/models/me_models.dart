class MeModel {
  final int id;
  final String email;
  final String username;
  final int role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  MeModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MeModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MeModel(
        id: 0,
        email: '',
        username: '',
        role: 0,
        isActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    return MeModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
