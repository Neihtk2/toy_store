import 'package:get/get.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
  }
}
