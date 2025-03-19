
import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/order_model.dart';

class OrderRepository {
  final ApiService _api = Get.find();
 Future<List<OrderModel>> getOrder(String token) async {
  try {
    final response = await _api.getOrder(token);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = response.data['data'];

      if (responseData == null || responseData['orders'] == null) {
        throw Exception("Dữ liệu API không hợp lệ.");
      }

      List<dynamic> ordersData = responseData['orders'];

      return ordersData.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải đơn hàng: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar(
      "Lỗi",
      "Không thể tải đơn hàng: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
    return [];
  }
}
}
