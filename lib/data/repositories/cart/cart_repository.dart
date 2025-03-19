import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';

class CartRepository {
  final ApiService _api = Get.find();
  Future<List<CartItem>> getCartItems(String token) async {
    try {
      final response = await _api.getCart(token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = response.data['data'] ?? [];
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


Future<void> postProducts(String id, String amount) async {
  String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);

  if (token == null || token.isEmpty) {
    Get.snackbar('Lỗi', 'Bạn chưa đăng nhập!', snackPosition: SnackPosition.BOTTOM);
    return;
  }

  final Map<String, dynamic> body = {
    "products": [
      {
        "id": int.parse(id),  // Chuyển đổi id sang int
        "amount": int.parse(amount) // Chuyển đổi amount sang int
      }
    ]
  };

  try {
    final response = await Dio().post(
      "https://kma-render.onrender.com/api/v1/orders/add-cart",
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Success: ${response.data}');
      Get.snackbar(
        'Thành công',
        'Sản phẩm đã được thêm vào giỏ hàng!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      print('Error: ${response.statusCode}');
      print('Response Body: ${response.data}');
      Get.snackbar(
        'Lỗi',
        'Không thể thêm sản phẩm vào giỏ hàng!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    print('Exception: $e');
    Get.snackbar(
      'Lỗi',
      'Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

}
