// lib/data/repositories/auth_repository.dart
import 'package:get/get.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/user_models.dart';



class AuthRepository {
  final ApiService _api = Get.find();
  Future<UserModel> login(String email, String password) async {
    final response = await _api.post(
      Endpoints.login,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }
}