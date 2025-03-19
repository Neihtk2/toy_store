import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/order/order_repository.dart';
import 'package:toyland_mobile/presentation/controllers/order_controller.dart';

class OrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(() => OrderRepository());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<ApiService>(() => ApiService());
  }
}