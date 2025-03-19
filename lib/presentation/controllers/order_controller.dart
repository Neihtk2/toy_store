import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/order_model.dart';
import 'package:toyland_mobile/data/repositories/order/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepository _repo = Get.find();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var orders = <OrderModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getOrder();
  }

  Future<void> getOrder() async {
    isLoading.value = true;

    String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      isLoading.value = false;
      return;
    }

    try {
      var fetchedCartData = await _repo.getOrder(token);
      orders.assignAll(fetchedCartData);
      error.value = '';
    } catch (e) {
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
