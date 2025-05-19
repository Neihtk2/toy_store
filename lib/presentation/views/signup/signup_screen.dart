import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';
import 'package:toyland_mobile/routes/router_name.dart';
import 'package:toyland_mobile/x_res/app_themes.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class SignupScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  RxString selectedGender = 'male'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Tạo tài khoản',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppThemes.Roboto,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Hãy cùng nhau tạo tài khoản!",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontFamily: AppThemes.Roboto,
                ),
              ),
              SizedBox(height: 10.h),
              _buildTextField("Tên"),
              _buildNameField(),
              SizedBox(height: 10.h),
              _buildTextField("Email"),
              _buildEmailField(),
              SizedBox(height: 10.h),
              _buildTextField("Mật khẩu"),
              _buildPasswordField(),
              SizedBox(height: 10.h),
              _buildTextField("Nhập lại mật khẩu"),
              _buildConfirmPasswordField(),
              SizedBox(height: 10.h),
              _buildTextField("Địa chỉ"),
              _buildAddressField(),
              SizedBox(height: 10.h),
              _buildTextField("Ngày sinh"),
              _buildDateOfBirthField(context),
              SizedBox(height: 10.h),
              _buildTextField("Giới tính"),
              _buildGenderSelection(),
              SizedBox(height: 20.h),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildRadioButton("male"),
          SizedBox(width: 10),
          _buildRadioButton("female"),
          SizedBox(width: 10),
          _buildRadioButton("other"),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String gender) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: gender,
          groupValue: selectedGender.value,
          onChanged: (value) => selectedGender.value = value!,
        ),
        Text(gender),
      ],
    );
  }

  Widget _buildTextField(String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              hint,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            Text(" *", style: TextStyle(color: Colors.red, fontSize: 18.sp)),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        fillColor: Colors.grey[100],
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAddressField() {
    return TextField(
      controller: _addressController,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        fillColor: Colors.grey[100],
        hintText: 'Địa chỉ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        fillColor: Colors.grey[100],
        hintText: 'Tên',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => TextField(
        controller: _passwordController,
        obscureText: controller.isPasswordHidden.value,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          fillColor: Colors.grey[100],
          hintText: 'Mật khẩu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              controller.isPasswordHidden.value =
                  !controller.isPasswordHidden.value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Obx(
      () => TextField(
        controller: _confirmPasswordController,
        obscureText: controller.isPasswordHidden.value,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          fillColor: Colors.grey[100],
          hintText: 'Nhập lại mật khẩu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              controller.isPasswordHidden.value =
                  !controller.isPasswordHidden.value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return TextField(
      controller: _dobController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          _dobController.text =
              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
      },
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        fillColor: Colors.grey[100],
        hintText: 'Chọn ngày sinh',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  Future<void> registerUser() async {
    Dio dio = Dio();
    DateTime? parsedDob;
    try {
      parsedDob = DateFormat("dd/MM/yyyy").parse(_dobController.text.trim());
    } catch (e) {
      Get.snackbar("Lỗi", "Ngày sinh không hợp lệ");
      return;
    }

    final formattedDob = DateFormat("yyyy-MM-dd").format(parsedDob);

    FormData formData = FormData.fromMap({
      'username': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'gender': selectedGender.value.trim(),
      'address': _addressController.text.trim(),
      'birth': formattedDob,
    });

    try {
      controller.isLoading.value = true;
      final response = await dio.post(
        'http://103.155.161.56:3100/api/v1/auth/sign-up',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      Get.snackbar(
        "Thành công",
        "Đăng ký thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(RouterName.login);
    } catch (e) {
      print('Error: $e');
    } finally {
      controller.isLoading.value = false;
    }
  }

  Widget _buildSignUpButton() {
    return Obx(
      () => InkWell(
        onTap:
            controller.isLoading.value
                ? null
                : () async {
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    Get.snackbar(
                      "Lỗi",
                      "Mật khẩu không khớp!",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  await registerUser();
                },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.blueAccent,
          ),
          height: 60.h,
          width: double.infinity,
          child:
              controller.isLoading.value
                  ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Center(
                    child: Text(
                      'ĐĂNG KÝ',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
