import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';
import 'package:toyland_mobile/presentation/views/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key) {
     Get.put(UserController()); // 🔥 Đăng ký tại đây (không tối ưu)
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Trang cá nhân",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Get.to(() => EditProfile());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = userController.user.value;
        if (user == null) {
          return Center(
            child: Text(
              userController.error.isNotEmpty
                  ? userController.error.value
                  : "Không thể tải thông tin người dùng!",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
// Debug API

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Ảnh đại diện
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 40),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Tên người dùng
              Text(
                user.username?.isNotEmpty == true ? user.username! : "Chưa có tên",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Các trường thông tin người dùng
              _buildProfileField("Tên", user.username ?? "Chưa có tên"),
              _buildProfileField("Địa chỉ email ", user.email ?? "Chưa có email"),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          obscureText: label == "Password",
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
