import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/me_models.dart';
import 'package:toyland_mobile/data/models/user_models.dart';

abstract class AuthRepositoryService {
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(
    String username,
    String email,
    String password,
    String gender,
    String address,
  );
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
  try {
    print("Gọi API lấy thông tin người dùng...");
    final response = await _api.getMe(token);
    print("Phản hồi API: ${response.statusCode} - ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.data;
      
      if (responseData == null || responseData['data'] == null) {
        print("Lỗi: Dữ liệu trả về từ API bị null");
        return null;
      }

      print("Dữ liệu người dùng: ${responseData['data']}");
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


  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}

