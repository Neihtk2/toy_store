import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/presentation/controllers/product_controller.dart';
import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';

class PopularToysScreen extends StatelessWidget {
  PopularToysScreen({super.key}) {
    Get.put(ProductController());
    Get.put(AuthRepository());
    // Đưa UserController vào GetX khi HomeItem được tạo
  }
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Popular Toys"),
        backgroundColor: const Color(0xFFF8F9FA),
      ),
      body: _buildGridList(),
    );
  }

  Widget _buildGridList() {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (productController.filteredProductItem.isEmpty) {
        return const Center(child: Text("Không có sản phẩm nào."));
      }

      return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 9,
          mainAxisSpacing: 8,
        ),
        itemCount: productController.filteredProductItem.length,
        itemBuilder: (context, index) {
          final watch = productController.filteredProductItem[index];
          return GestureDetector(
            onTap: () {
              Get.to(
                () => ToyDetailScreen(watch: watch),
              ); // Truyền dữ liệu vào màn hình chi tiết
            },
            child: WatchCard(watch: watch),
          );
        },
      );
    });
  }
}
