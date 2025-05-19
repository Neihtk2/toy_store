import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/me_models.dart';
import 'package:toyland_mobile/data/models/user_models.dart';

abstract class AuthRepositoryService {
  Future<UserModel?> login(String email, String password);
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String address,
    required String gender,
    // required String date,
  });
  Future<void> logout();
}

class AuthRepository implements AuthRepositoryService {
  final ApiService _api = Get.find();
  // final ApiService _api;
  // AuthRepository(this._api);
  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _api.LoginApp(email, password);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<MeModel?> getUser(String token) async {
    final box = GetStorage();
    try {
      final response = await _api.getMe(token);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;

        if (responseData == null || responseData['data'] == null) {
          print("Lỗi: Dữ liệu trả về từ API bị null");
          return null;
        }

        // Lấy userId từ response và lưu vào box
        final userId =
            responseData['data']['id']; // Hoặc responseData['data']['userId'] tùy vào API
        box.write(MyConfig.USER_ID, userId);

        return MeModel.fromJson(responseData['data']);
      } else {
        print("Lỗi: API trả về mã trạng thái ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return null;
    }
  }

  UserModel? _handleResponse(Response response) {
    if (response.statusCode != 200 && response.statusCode != 201) return null;
    try {
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw const FormatException('Invalid user data format');
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      Get.snackbar('Error', error.response?.data['message'] ?? error.message);
    } else {
      Get.snackbar('Error', error.toString());
    }
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String address,
    required String gender,

    // required String date,
  }) async {
    try {
      final response = await _api.registerApp(
        name: username,
        email: email,
        password: password,
        address: address,
        gender: gender,
        // date: date,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Registration successful',
          snackPosition: SnackPosition.BOTTOM,
        );
        // return UserModel.fromJson(response.data['data']);
      } else {
        Get.snackbar(
          'Error',
          'Registration failed: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
