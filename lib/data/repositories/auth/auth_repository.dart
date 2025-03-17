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
  Future<UserModel?> getUser(String token) async {
  try {
    print("Gọi API lấy thông tin người dùng...");
    final response = await _api.getMe(token);
    print("Phản hồi API: ${response.statusCode} - ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Dữ liệu người dùng: ${response.data['data']}");
      return UserModel.fromJson(response.data['data']);
    } else {
      print("Lỗi: API trả về mã trạng thái ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Lỗi khi gọi API: $e");
    return null;
  }
}


  Future<UserModel?> register(
    String username,
    String email,
    String password,
    String gender,
    String address,
  ) async {
    try {
      final response = await _api.registerApp(
        username,
        email,
        password,
        gender,
        address,
      );
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