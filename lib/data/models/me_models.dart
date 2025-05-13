class MeModel {
  final int id;
  final String email;
  final String username;
  final String? phoneNumber;
  final String? gender;
  final int role;
  final String? avatar;
  final DateTime? birth;
  final String? address;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  MeModel({
    required this.id,
    required this.email,
    required this.username,
    this.phoneNumber,
    this.gender,
    required this.role,
    this.avatar,
    this.birth,
    this.address,
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
        phoneNumber: null,
        gender: null,
        role: 0,
        avatar: null,
        birth: null,
        address: null,
        isActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    return MeModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      role: json['role'] ?? 0,
      avatar: json['avatar'],
      birth: json['birth'] != null ? DateTime.tryParse(json['birth']) : null,
      address: json['address'],
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
