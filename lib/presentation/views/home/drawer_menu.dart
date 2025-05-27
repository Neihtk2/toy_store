import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toyland_mobile/presentation/controllers/like_controller.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';
import 'package:toyland_mobile/presentation/views/home/filter_product.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Drawer(
      child: Container(
        color: const Color(0xFF1D2630),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final user = userController.user.value;

              return DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF1D2630)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: user?.avatar != null
                          ? NetworkImage(user!.avatar!)
                          : const NetworkImage("https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/09/19/467/avatar-anime-nam-10.jpg")
                              as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: 10),

                    // Lời chào
                    const Text(
                      "Xin chào!, 👋",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                    // Tên người dùng
                    Text(
                      user?.username ?? "Người dùng",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // Các mục menu
            GestureDetector(
              onTap: () async {
                final likeController = Get.find<LikeController>();

                if (likeController.likedProducts.isEmpty) {
                  await likeController.fetchLikedProductsDetail();
                }

                Get.to(() => FilterProductScreen(
                      products: likeController.likedProducts
                          .map((e) => e.product)
                          .toList(),
                      title: "Các sản phẩm yêu thích",
                    ));
              },
              child: _buildDrawerItem(Icons.favorite, "Các sản phẩm yêu thích"),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(RouterName.cart),
              child: _buildDrawerItem(Icons.shopping_bag_outlined, "Giỏ hàng của tôi")),
            // _buildDrawerItem(Icons.local_shipping_outlined, "Orders"),

            const Divider(color: Colors.white54, thickness: 0.5),
            GestureDetector(
              onTap: () => userController.signOut(),
              child: _buildDrawerItem(Icons.logout, "Đăng xuất")),
          ],
        ),
      ),
    );
  }
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

