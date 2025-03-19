

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';

class ToysBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(() => CartRepository());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ApiService>(() => ApiService());
  }
}