import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyland_mobile/data/models/order_model.dart';
import 'package:toyland_mobile/data/repositories/order/order_repository.dart';
import 'package:toyland_mobile/presentation/controllers/order_controller.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  final OrderRepository orderRepository = Get.put(OrderRepository());
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
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
                    "Toyland Store", // Tạm thời fix tên cửa hàng
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                order.status,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Hình ảnh + Chi tiết sản phẩm
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000'", // Tạm thời fix ảnh
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
                      order.orderDetails[0].productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "x${order.orderDetails[0].amount}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\đ${NumberFormat("#,###.##", "en_US").format(order.orderDetails[0].unitPrice)}",
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
          const Divider(thickness: 1, height: 30),

          // Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${order.totalAmount} Product(s)",
                style: const TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  const Text(
                    "Total: ",
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
              // Văn bản cảnh báo
              const Expanded(
                child: Text(
                  'Please only click "Order Received" once the order has been delivered to you and there are no problems with the product.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),

              // Nút "Order Received"
              ElevatedButton(
                onPressed: () {
                  // TODO: Gọi API xác nhận đơn hàng
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor:
                      Colors.red.shade200, // Làm mờ khi disable
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Order Received",
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
}
