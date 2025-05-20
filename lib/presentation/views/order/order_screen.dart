import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyland_mobile/data/models/order_model.dart';
import 'package:toyland_mobile/data/repositories/order/order_repository.dart';
import 'package:toyland_mobile/presentation/controllers/order_controller.dart';
import 'package:toyland_mobile/presentation/views/order/rating_screen.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          "Đơn hàng của tôi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }
        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            return _buildOrderItem(orderController.orders[index]);
          },
        );
      }),
    );
  }

  Widget _buildOrderItem(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên cửa hàng + trạng thái đơn hàng
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.store),
                  SizedBox(width: 5),
                  Text(
                    "Watch Store", // Tạm thời fix tên cửa hàng
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                getVietnameseStatus(order.status),
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Danh sách sản phẩm trong đơn hàng
          Column(
            children:
                order.orderDetails.map((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            detail.product!.images[0].url,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detail.productName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "x${detail.amount}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "\đ${NumberFormat("#,###.##", "en_US").format(detail.unitPrice)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),

          const Divider(thickness: 1, height: 30),

          // Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${order.totalAmount} Sản phẩm",
                style: const TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  const Text(
                    "Tổng: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\đ${NumberFormat("#,###.##", "en_US").format(double.parse(order.totalPrice))}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Divider(thickness: 1, height: 30),

          // Lưu ý + Nút xác nhận
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Vui lòng chỉ nhấp vào "Đã nhận đơn hàng" khi đơn hàng đã được giao cho bạn và không có vấn đề gì với sản phẩm.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final rating = await Get.dialog(RatingDialog());

                  if (rating != null && rating > 0) {
                    final controller = Get.find<OrderController>();

                    await controller.createRate(
                      productId:
                          order
                              .orderDetails
                              .first
                              .productId, // đảm bảo bạn có productId ở đây
                      rate: rating.toInt(),
                      orderId: order.id,
                    );

                    if (controller.error.value.isEmpty) {
                      Get.snackbar(
                        'Thành công',
                        'Bạn đã đánh giá ${rating.toInt()} sao cho sản phẩm!',
                      );
                    } else {
                      Get.snackbar('Lỗi', controller.error.value);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.red.shade200,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Đã nhận hàng",

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getVietnameseStatus(String status) {
    switch (status) {
      case 'waiting_payment':
        return 'Chờ thanh toán';
      case 'waiting_confirm':
        return 'Chờ xác nhận';
      case 'success':
        return 'Thành công';
      case 'reject':
        return 'Đã hủy';
      default:
        return 'Đang chờ xử lý';
    }
  }
}
