import 'package:get/get.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';

class WatchResponsitory {
  final ApiService _api = Get.find();

  Future<List<WatchModel>> getProductItems(String token) async {
    try {
      //print("🔹 Gọi API lấy sản phẩm...");
      final response = await _api.getProducts(token);
      //print("📥 API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Kiểm tra xem `data` có chứa danh sách sản phẩm hay không
        var productsData = response.data['data']['products'];
        
        if (productsData is List) {
          return productsData.map((json) => WatchModel.fromJson(json)).toList();
        } else {
          throw Exception("Dữ liệu sản phẩm không hợp lệ!");
        }
      } else {
        throw Exception("Lỗi khi tải giỏ hàng: ${response.statusCode}");
      }
    } catch (e) {
      //print("❌ Lỗi khi gọi API: $e");
      Get.snackbar("Lỗi", "Không thể tải giỏ hàng: $e", snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }
}
