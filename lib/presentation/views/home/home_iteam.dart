import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toyland_mobile/presentation/views/home/drawer_menu.dart';
import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/home/toylist.dart';
import 'package:toyland_mobile/presentation/views/search/search_screen.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';

class HomeItem extends StatelessWidget {
  HomeItem({super.key});

  final List<Map<String, dynamic>> toys = [
    {
      'name': 'Nike Jordan',
      'price': '\$493.00',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
    {
      'name': 'Nike Air Max',
      'price': '\$897.99',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
    {
      'name': 'Nike Jordan',
      'price': '\$493.00',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
    {
      'name': 'Nike Air Max',
      'price': '\$897.99',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
    {
      'name': 'Nike Jordan',
      'price': '\$493.00',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
    {
      'name': 'Nike Air Max',
      'price': '\$897.99',
      'image':
          'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000',
    },
  ];

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PopularToysScreen()),
              );
            }),
            _buildSection("New Toys", _buildVerticalList(), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewToysScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
        Stack(
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
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => Get.to(() => SearchScreen()), // Điều hướng sang màn tìm kiếm
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
              "Looking for shoes",
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: toys.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ToyDetailScreen());
            },
            child: ShoeCard(shoe: toys[index]),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: toys.length,
      itemBuilder: (context, index) => ToyCard(product: toys[index]),
    );
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

// =======================
// Tạo màn hình mới
// =======================
class PopularToysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Popular Toys")),
      body: const Center(child: Text("Danh sách Popular Toys ở đây")),
    );
  }
}

class NewToysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Toys")),
      body: const Center(child: Text("Danh sách New Toys ở đây")),
    );
  }
}
