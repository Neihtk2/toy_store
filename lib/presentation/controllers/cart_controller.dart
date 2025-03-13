import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _repo = Get.find();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var filteredCartItem = <CartItem>[].obs;
  String token = GetStorage().read(MyConfig.ACCESS_TOKEN);
  @override
  onInit() {
    super.onInit();
    getCart();
  }

  Future<void> getCart() async {
    if (token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      return;
    }
    try {
      isLoading(true);
      var fetchedCartData = await _repo.getCartItems(token);
      filteredCartItem.assignAll(fetchedCartData);
    } finally {
      isLoading(false);
    }
  }
}
