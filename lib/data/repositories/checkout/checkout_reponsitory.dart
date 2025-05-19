import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/core/network/api_service.dart';

class CheckoutReponsitory {
  final ApiService _api = Get.find();
  String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
  Future<void> checkout(
    String phone,
    String receiver,
    String address,
    String note,
  ) async {
    try {
      final response = await _api.dio.post(
        Endpoints.checkout,
        data: {
          "paymentType": "offline",
          'phone': phone,
          'receiver': receiver,
          'address': address,
          'note': note,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception("Lỗi khi thanh toán: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Không thể thanh toán: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> checkoutWithVNPay(
    String phone,
    String receiver,
    String address,
    String note,
  ) async {
    try {
      final response = await _api.dio.post(
        Endpoints.checkoutVNPay,
        data: {
          "bankCode": "VNBANK",
          'phone': phone,
          'receiver': receiver,
          'address': address,
          'note': note,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            // "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception("Lỗi khi thanh toán: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Không thể thanh toán: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
