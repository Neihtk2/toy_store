import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/data/repositories/watch/watch_responsitory.dart';
import 'package:toyland_mobile/presentation/controllers/product_controller.dart';
import 'package:toyland_mobile/presentation/views/home/drawer_menu.dart';
import 'package:toyland_mobile/presentation/views/home/top_product.dart';
import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/home/toylist.dart';
import 'package:toyland_mobile/presentation/views/search/search_screen.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class HomeItem extends StatelessWidget {
  HomeItem({super.key}) {
    Get.put(ProductController());
    Get.put(AuthRepository()); 
 // Đưa UserController vào GetX khi HomeItem được tạo
  }
  
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildCategoryIcons(),
            const SizedBox(height: 10),
            _buildSection("Popular Toys", _buildHorizontalList(), () {
              Get.to(() => PopularToysScreen());
            }),
            const SizedBox(height: 10),
            _buildSection("New Toys", _buildVerticalList(), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PopularToysScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false, 
      backgroundColor: const Color(0xFFF8F9FA),
      elevation: 0,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: Colors.red, size: 18),
          SizedBox(width: 4),
          Text(
            "ToyLand",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      centerTitle: true,

      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouterName.cart);
          },
          child: Stack(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 26,
                  color: Colors.black,
                ),
              ),
              Positioned(top: 5, right: 5, child: _NotificationDot()),
            ],
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      // onTap: () => Get.to(() => SearchScreen()), // Điều hướng sang màn tìm kiếm
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14), // Thêm padding
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text(
              "Looking for toys",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcons() {
    final icons = [
      Icons.toys_rounded,
      Icons.abc,
      Icons.access_alarm,
      Icons.toys,
      Icons.toys_sharp,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: icons.map((icon) => _CircleIcon(icon: icon)).toList(),
    );
  }

  Widget _buildSection(String title, Widget content, VoidCallback onSeeAll) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                "See all",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

 Widget _buildHorizontalList() {
  return Obx(() {
    if (productController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (productController.filteredProductItem.isEmpty) {
      return const Center(child: Text("Không có sản phẩm nào."));
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productController.filteredProductItem.length,
        itemBuilder: (context, index) {
          final watch = productController.filteredProductItem[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Khoảng cách giữa các item
            child: GestureDetector(
              onTap: () {
                 Get.to(() => ToyDetailScreen(watch: watch)); 
              },
              child: WatchCard(watch: watch),
            ),
          );
        },
      ),
    );
  });
}



Widget _buildVerticalList() {
  return Obx(() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productController.filteredProductItem.length,
      itemBuilder: (context, index) {
        final watch = productController.filteredProductItem[index];
        return GestureDetector(
           onTap: () {
                 Get.to(() => ToyDetailScreen(watch: watch)); 
              },
          child: ToyCard(product: watch)); // ✅ Thêm `return`
      },
    );
  });
}
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(icon, size: 26, color: Colors.black),
    );
  }
}

class _NotificationDot extends StatelessWidget {
  const _NotificationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}

