import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';
import 'package:toyland_mobile/x_res/app_themes.dart';

class SignupScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  RxString selectedGender = 'Male'.obs;

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
                'Create Account',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppThemes.Roboto,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Let's Create Account Together",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontFamily: AppThemes.Roboto,
                ),
              ),
              SizedBox(height: 10.h),
              _buildTextField("Your name"),
              _buildNameField(),
              SizedBox(height: 10.h),
              _buildTextField("Email"),
              _buildEmailField(),
              SizedBox(height: 10.h),
              _buildTextField("Password"),
              _buildPasswordField(),
              SizedBox(height: 10.h),
              _buildTextField("Address"),
              _buildAddressField(),
              SizedBox(height: 10.h),
              _buildTextField("Gender"),
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
          _buildRadioButton("Male"),
          SizedBox(width: 10),
          _buildRadioButton("Female"),
          SizedBox(width: 10),
          _buildRadioButton("Other"),
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
        hintText: 'Address',
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
        hintText: 'Name',
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
          hintText: 'Password',
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

  Widget _buildSignUpButton() {
    return Obx(
      () => InkWell(
        onTap: controller.isLoading.value
            ? null
            : () => controller.register(
                _nameController.text.trim(),
                _emailController.text.trim(),
                _passwordController.text.trim(),
                _addressController.text.trim(),
                selectedGender.value.trim(),
              ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.blueAccent,
          ),
          height: 60.h,
          width: double.infinity,
          child: controller.isLoading.value
              ? const CircularProgressIndicator()
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
