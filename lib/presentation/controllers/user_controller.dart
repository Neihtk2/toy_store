

import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/data/models/me_models.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';

class UserController extends getx.GetxController {
  final AuthRepository _repo = AuthRepository();
  final getx.Rx<MeModel?> user = getx.Rx<MeModel?>(null);
  final getx.RxBool isLoading = false.obs;
  final getx.RxString error = ''.obs;
  final Dio _dio = Dio();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  /// Lấy thông tin người dùng từ API
  Future<void> getUser() async {
    isLoading.value = true;
    error.value = '';

    final token = box.read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      isLoading.value = false;
      return;
    }

    try {
      print("🔹 Fetching user with token: $token");
      final fetchedUser = await _repo.getUser(token);

      if (fetchedUser != null) {
        user.value = fetchedUser;
        print("✅ User fetched successfully: ${user.value}");
      } else {
        error.value = "Không thể tải thông tin người dùng!";
        print("❌ API trả về null.");
      }
    } catch (e) {
      error.value = "Lỗi khi lấy thông tin người dùng.";
      print("⚠️ Lỗi khi gọi API: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Cập nhật thông tin người dùng
  Future<void> updateUserInfo({
    required int userId,
    required String username,
    String? phoneNumber,
    String? gender,
    String? address,
  }) async {
    isLoading.value = true;
    error.value = '';

    final token = box.read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = 'Bạn chưa đăng nhập!';
      isLoading.value = false;
      return;
    }

    try {
      final response = await _dio.patch(
        '${MyConfig.BASE_URL}${Endpoints.updateMe}/$userId',
        data: {
          'username': username,
          'phoneNumber': phoneNumber,
          'gender': gender,
          'address': address,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Cập nhật thông tin thành công");
        await getUser(); // Cập nhật lại thông tin sau khi thay đổi
      } else {
        error.value = 'Cập nhật thất bại';
        print("❌ Response: ${response.data}");
      }
    } catch (e) {
      error.value = 'Lỗi khi cập nhật: $e';
      print("❌ Lỗi cập nhật người dùng: $e");
    } finally {
      isLoading.value = false;
    }
  }


Future<void> uploadAvatar(File file) async {
isLoading.value = true;
  error.value = '';

  try {
    final token = box.read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = 'Bạn chưa đăng nhập!';
      isLoading.value = false;
      return;
    }

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: path.basename(file.path),
        contentType: _getContentType(file),
      ),
    });

    final response = await _dio.post(
      'http://103.155.161.56:3100/api/v1/auth/avatar',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Avatar uploaded successfully");
      await getUser(); // Tải lại thông tin user
    } else {
      error.value = 'Tải ảnh thất bại! Mã lỗi: ${response.statusCode}';
      print('❌ Server error: ${response.statusCode} ${response.data}');
    }
  } catch (e) {
    error.value = 'Lỗi khi tải ảnh: $e';
    print("❌ Upload avatar error: $e");
  } finally {
    isLoading.value = false;
  }
}

MediaType? _getContentType(File file) {
  final extension = path.extension(file.path).toLowerCase();
  if (['.jpg', '.jpeg', '.png'].contains(extension)) {
    return MediaType('image', extension == '.png' ? 'png' : 'jpeg');
  }
  return null;
}

}
