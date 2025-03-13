import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/user_models.dart';

class AuthRepository {
  final ApiService _api = Get.find();
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _api.LoginApp(email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _api.registerApp(username, email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
