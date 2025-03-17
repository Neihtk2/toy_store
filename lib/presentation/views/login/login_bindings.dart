import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    // Get.lazyPut<AuthRepository>(() => AuthRepository());
  }
}
