import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toyland_mobile/presentation/controllers/like_controller.dart';
import 'package:toyland_mobile/presentation/views/home/filter_product.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1D2630), // Màu nền tối
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần Header (Ảnh đại diện + Tên)
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF1D2630)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/467/avatar-anime-nam-10.jpg',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Lời chào
                  const Text(
                    "Hey, 👋",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  // Tên người dùng
                  const Text(
                    "Alisson Becker",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Danh sách menu
            GestureDetector(
              onTap: () async {
                final likeController = Get.find<LikeController>();

                // Nếu chưa fetch thì gọi để chắc chắn dữ liệu có sẵn
                if (likeController.likedProducts.isEmpty) {
                  await likeController.fetchLikedProductsDetail();
                }

                Get.to(
                  () => FilterProductScreen(
                    products:
                        likeController.likedProducts
                            .map((e) => e.product)
                            .toList(),
                    title: "Các sản phẩm yêu thích",
                  ),
                );
              },

              child: _buildDrawerItem(Icons.favorite, "Đã thích"),
            ),
            _buildDrawerItem(Icons.home_outlined, "Home Page"),
            _buildDrawerItem(Icons.shopping_bag_outlined, "My Cart"),

            _buildDrawerItem(Icons.local_shipping_outlined, "Orders"),

            // Dòng kẻ ngăn cách
            const Divider(color: Colors.white54, thickness: 0.5),

            // Nút Sign Out
            _buildDrawerItem(Icons.logout, "Sign Out"),
          ],
        ),
      ),
    );
  }

  // Widget tạo mục menu
  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
