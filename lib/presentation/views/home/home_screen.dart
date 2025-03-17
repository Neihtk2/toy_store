import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';

import 'package:toyland_mobile/presentation/views/home/home_iteam.dart';
import 'package:toyland_mobile/presentation/views/order/order_screen.dart';
import 'package:toyland_mobile/presentation/views/profile/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeItem(), OrderListScreen(), ProfileScreen()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(UserController());
    Get.put(CartRepository());
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA), // Để thấy rõ Bottom Bar
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFF8F9FA)!,
        color: Colors.white, // Màu của thanh navigation bar
        buttonBackgroundColor: Colors.blue, // Màu nền của nút được chọn
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            color:
                _selectedIndex == 0
                    ? Colors.white
                    : Colors.grey, // Trắng khi chọn, xám khi chưa chọn
          ),

          Icon(
            Icons.local_shipping_outlined,
            size: 30,
            color: _selectedIndex == 1 ? Colors.white : Colors.grey,
          ),

          Icon(
            Icons.person_outline,
            size: 30,
            color: _selectedIndex == 2 ? Colors.white : Colors.grey,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
