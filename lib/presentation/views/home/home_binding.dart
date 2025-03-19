import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/data/repositories/watch/watch_responsitory.dart';
import 'package:toyland_mobile/presentation/controllers/product_controller.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<WatchResponsitory>(() => WatchResponsitory());
    Get.lazyPut<ApiService>(() => ApiService());
  }
}
