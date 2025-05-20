import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:toyland_mobile/data/models/me_models.dart';
import 'package:toyland_mobile/presentation/controllers/user_controller.dart';


class EditProfile extends StatefulWidget {
  final MeModel user;

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String _gender = "male";

  final UserController _userController = getx.Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.username ?? "");
    _emailController = TextEditingController(text: widget.user.email ?? "");
    _phoneController = TextEditingController(
      text: widget.user.phoneNumber ?? "",
    );
    _addressController = TextEditingController(text: widget.user.address ?? "");
    _gender = widget.user.gender ?? "male";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    await _userController.updateUserInfo(
      userId: widget.user.id!,
      username: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      gender: _gender,
      address: _addressController.text.trim().isEmpty
          ? null
          : _addressController.text.trim(),
    );

    if (_userController.error.isEmpty) {
      getx.Get.snackbar(
        "Thành công",
        "Cập nhật thông tin cá nhân thành công",
        snackPosition: getx.SnackPosition.BOTTOM,
        colorText: Colors.black,
      );
    } else {
      getx.Get.snackbar(
        "Thất bại",
        _userController.error.value,
        snackPosition: getx.SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Chỉnh sửa thông tin cá nhân",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),


      ),
      body: getx.Obx(() {
        return _userController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          getx.Obx(() {
                            final user = _userController.user.value;
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: user?.avatar != null
                                  ? NetworkImage(user!.avatar!)
                                  : null,
                              child: user?.avatar == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            );
                          }),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  await _userController
                                      .uploadAvatar(File(image.path));
                                  if (_userController.error.isEmpty) {
                                    getx.Get.snackbar(
                                      "Thành công",
                                      "Tải ảnh đại diện thành công",
                                      snackPosition:
                                          getx.SnackPosition.BOTTOM,
                                    );
                                  } else {
                                    getx.Get.snackbar(
                                      "Lỗi",
                                      _userController.error.value,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition:
                                          getx.SnackPosition.BOTTOM,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Tên
                    Text(
                      widget.user.username ?? "Chưa có tên",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Fields
                    _buildProfileField("Tên", _nameController),
                    _buildProfileField(
                      "Địa chỉ email",
                      _emailController,
                      readOnly: true,
                    ),
                    _buildProfileField("Số điện thoại", _phoneController),
                    _buildProfileField("Địa chỉ", _addressController),

                    // Giới tính
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Giới tính",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Nam"),
                            value: "male",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() => _gender = value.toString());
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Nữ"),
                            value: "female",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() => _gender = value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _updateProfile,
                        child: const Text(
                          "Cập nhật",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? Colors.grey.shade200 : Colors.grey.shade100,
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
