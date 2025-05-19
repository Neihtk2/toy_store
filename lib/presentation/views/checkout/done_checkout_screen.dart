import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class DoneCheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đặt hàng thành công")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Cảm ơn bạn đã đặt hàng!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Đơn hàng của bạn đã được xác nhận.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(RouterName.home);
                // Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Quay lại trang chính"),
            ),
          ],
        ),
      ),
    );
  }
}
