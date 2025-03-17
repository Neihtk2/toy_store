// lib/presentation/controllers/auth_controller.dart

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/user_models.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isPasswordHidden = false.obs;
  final box = GetStorage();
  
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        final user = await _repo.login(email, password);
        if (user != null) {
          _saveTokens(user.accessToken, user.refreshToken);
          print("ddd");
          print(user.accessToken);
          print("ddd");

          Get.toNamed(RouterName.home);
        } else {
          Get.snackbar('Error', 'Login failed');
        }
      }
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }
   

  Future<void> register(
    String name,
    String email,
    String password,
    String render,
    String address,
  ) async {
    isLoading.value = true;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // final response = await _apiService.LoginApp(username, password);
        final user = await _repo.register(
          name,
          email,
          password,
          render,
          address,
        );
        if (user != null) {
          _saveTokens(user.accessToken, user.refreshToken);
          Get.toNamed(RouterName.home);
        } else {
          Get.snackbar('Error', 'Login failed');
        }
      }
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void _saveTokens(String? accessToken, String? refreshToken) {
    if (accessToken != null && refreshToken != null) {
      box.write(MyConfig.ACCESS_TOKEN, accessToken);
      box.write(MyConfig.REFRESH_TOKEN, refreshToken);
    }
  }

  Future<void> forgotpass(String email) async {}

}

void _handleError(dynamic e) {
  final message =
      e is DioException
          ? e.response?.data['message'] ?? e.message
          : e.toString();
  Get.snackbar('Error', message);
}

