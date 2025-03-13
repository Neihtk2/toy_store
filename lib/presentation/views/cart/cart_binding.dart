import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';
=======
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';
>>>>>>> origin

class CartBinding extends Bindings {
  @override
  void dependencies() {
<<<<<<< HEAD
    // Get.lazyPut<AuthController>(() => AuthController());
=======
    Get.lazyPut<CartRepository>(() => CartRepository());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ApiService>(() => ApiService());
>>>>>>> origin
  }
}
