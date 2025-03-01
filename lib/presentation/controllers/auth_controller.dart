// lib/presentation/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyland_mobile/data/models/user_models.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = Get.find();
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
final RxBool isPasswordHidden = false.obs;
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final UserModel result = await _repo.login(email, password);
      user.value = result;
      // Lưu token
      final prefs = Get.find<SharedPreferences>();
      await prefs.setString('auth_token', result.token!);
      Get.offAllNamed(RouterName.home); // Chuyển màn hình
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> signup(String name, String email, String password) async {}
  Future<void> forgotpass( String email) async {}
}
