import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _repo = Get.find();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var filteredCartItem = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  Future<void> getCart() async {
    isLoading.value = true;

    String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      isLoading.value = false;
      return;
    }

    try {
      var fetchedCartData = await _repo.getCartItems(token);
      filteredCartItem.assignAll(fetchedCartData);
      error.value = '';
    } catch (e) {
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCart(String id, String amount) async {
    isLoading.value = true;
    String token = GetStorage().read(MyConfig.ACCESS_TOKEN);

    if (id.isEmpty || amount.isEmpty) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng nhập đầy đủ thông tin sản phẩm',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    try {
      await _repo.postProducts(id, amount);

      // Hiển thị thông báo thành công
     
    } catch (e) {
      error.value = "Lỗi khi thêm vào giỏ hàng: $e";
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra khi thêm vào giỏ hàng',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
