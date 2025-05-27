import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/data/models/order_model.dart';
import 'package:toyland_mobile/data/repositories/order/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepository _repo = OrderRepository();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var orders = <OrderModel>[].obs;
   final Dio _dio = Dio();
  final box = GetStorage();
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

Future<void> createRate({
  required int productId,
  required int orderId,
  required int rate, // ví dụ từ 1 đến 5
}) async {
  isLoading.value = true;
  error.value = '';

  final token = box.read(MyConfig.ACCESS_TOKEN);
  if (token == null || token.isEmpty) {
    error.value = 'Bạn chưa đăng nhập!';
    isLoading.value = false;
    return;
  }

  try {
    final response = await _dio.post(
      '${MyConfig.BASE_URL}${Endpoints.postRate}',
      data: {
        "productId": productId,
        "rate": rate,
        "orderId": orderId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Đánh giá thành công");
      // Có thể gọi lại hàm fetch để cập nhật giao diện nếu cần
    } else {
      error.value = 'Đánh giá thất bại';
      print("❌ Response: ${response.data}");
    }
  } catch (e) {
    error.value = 'Lỗi khi gửi đánh giá: $e';
    print("❌ Lỗi đánh giá sản phẩm: $e");
  } finally {
    isLoading.value = false;
  }
}
Future<void> updateOrder({
  required String status,
  required int orderId, // ví dụ từ 1 đến 5
}) async {
  isLoading.value = true;
  error.value = '';

  final token = box.read(MyConfig.ACCESS_TOKEN);
  if (token == null || token.isEmpty) {
    error.value = 'Bạn chưa đăng nhập!';
    isLoading.value = false;
    return;
  }
  try {
    final response = await _dio.put(
      'http://103.155.161.56:3100/api/v1/orders/$orderId/change-status',
      data: {
        "status": status   
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Đánh giá thành công");
      // Có thể gọi lại hàm fetch để cập nhật giao diện nếu cần
    } else {
      error.value = 'Đánh giá thất bại';
      print("❌ Response: ${response.data}");
    }
  } catch (e) {
    error.value = 'Lỗi khi gửi đánh giá: $e';
    print("❌ Lỗi đánh giá sản phẩm: $e");
  } finally {
    isLoading.value = false;
  }
}

}
