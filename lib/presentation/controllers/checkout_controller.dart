import 'package:get/get.dart';
import 'package:toyland_mobile/data/repositories/checkout/checkout_reponsitory.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';
import 'package:toyland_mobile/presentation/controllers/order_controller.dart';
import 'package:toyland_mobile/presentation/views/checkout/done_checkout_screen.dart';

class CheckoutController extends GetxController {
  CheckoutReponsitory _repo = CheckoutReponsitory();
  CartController cartController = Get.find();
  OrderController orderController = Get.find();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  Future<void> checkout(
    String phone,
    String receiver,
    String address,
    String note,
  ) async {
    try {
      isLoading.value = true;
      await _repo.checkout(phone, receiver, address, note);
      await cartController.getCart();
      await orderController.getOrder();
      Get.offAll(
        () => DoneCheckoutScreen(),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkoutWithVNPay(
    String phone,
    String receiver,
    String address,
    String note,
  ) async {
    try {
      isLoading.value = true;
      await _repo.checkoutWithVNPay(phone, receiver, address, note);
      await cartController.getCart();
      await orderController.getOrder();
      Get.offAll(
        () => DoneCheckoutScreen(),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
