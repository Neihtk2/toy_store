
import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';

class CartRepository {
  final ApiService _api = Get.find();
  Future<List<CartItem>> getCartItems(String token) async {
    try {
      final response = await _api.getCart(token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => CartItem.fromJson(json)).toList();
      } else {
        throw Exception("Lỗi khi tải giỏ hàng: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Không thể tải giỏ hàng: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
