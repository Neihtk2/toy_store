// lib/presentation/views/auth/login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';
import 'package:toyland_mobile/routes/router_name.dart';
import 'package:toyland_mobile/x_res/app_themes.dart';


class LoginScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Container(
        // color: Colors.white70,
        margin: EdgeInsets.symmetric(horizontal: 35.r),
        child: 
           SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 60.h),
                Center(
                  child: Text(
                    'Chào mừng trở lại!',
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                  ),
                ),
                 SizedBox(height: 30.h),
                Center(child: _buildSignUpOptions()),
                 SizedBox(height: 30.h),
                 Center(
                  child: Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                  ),
                ),
                  SizedBox(height: 30.h),
                 Text(
                  'Email',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                ),
                 SizedBox(height: 20.h),
                _buildEmailField(),
                 SizedBox(height: 20.h),
                 Text(
                  'Mật khẩu*',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                ),
                 SizedBox(height: 20.h),
                _buildPasswordField(),
                 SizedBox(height: 30.h),
                _buildLoginButton(),
                SizedBox(height: 20.h),
                _buildFooter(),
              ],
            ),
          ),
        ));
     
    
  }

  Widget _buildSignUpOptions() {
    return Column(
      children: [
        RichText(
    text: TextSpan(
      text: 'Bạn chưa có tài khoản? ',
      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16.sp, fontFamily: AppThemes.Roboto), // Màu mặc định cho văn bản
      children: [
        TextSpan(
          text: 'Đăng ký ngay',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: AppThemes.Roboto), // Màu nhấn cho Sign Up
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.toNamed(RouterName.signup), // Xử lý khi ấn vào "Sign Up"
        ),
      ],
    ),
  ),
  SizedBox(height: 20.h),
            RichText(
    text: TextSpan(
      text: 'Bạn chưa có tài khoản Face? ',
      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16.sp, fontFamily: AppThemes.Roboto), // Màu mặc định cho văn bản
      children: [
        TextSpan(
          text: 'Đăng ký Face',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: AppThemes.Roboto), // Màu nhấn cho Sign Up
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.toNamed(RouterName.signup), // Xử lý khi ấn vào "Sign Up"
        ),
      ],
      
    ),
  ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      obscureText: true,
      decoration: InputDecoration(
         focusedBorder:OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
             enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
             filled: true,
             fillColor: Colors.white,
        hintText: 'example@gmail.com',
        hintStyle: TextStyle(color: Colors.black26,fontWeight: FontWeight.w600,fontSize: 16.sp, fontFamily: AppThemes.Roboto),
        border:  OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
          controller: _passwordController,
          obscureText: controller.isPasswordHidden.value,
          decoration: InputDecoration(
             focusedBorder:OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
             enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
             filled: true,
             fillColor: Colors.white,
            hintText: 'Nhập mật khẩu',
            hintStyle: TextStyle(color: Colors.black26,fontWeight: FontWeight.w600,fontSize: 16.sp, fontFamily: AppThemes.Roboto),
            border:  OutlineInputBorder(borderSide: Divider.createBorderSide(Get.context)),
            errorText: controller.error.isNotEmpty ? controller.error.value : null,
           suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordHidden.value
                  ? Icons.visibility_off // Icon khi mật khẩu đang ẩn
                  : Icons.visibility, // Icon khi mật khẩu đang hiện
            ),
            onPressed: () {
              controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
            },
          ),
          ),
          
        ));
  }

  Widget _buildLoginButton() {
    return Obx(() => InkWell(
      onTap: controller.isLoading.value
          ? null
          : () => controller.login(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
           color: Colors.blueAccent,
        ),
        height: 50.h,
        width: double.infinity,
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  :  Center(child: Text('ĐĂNG NHẬP',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.white),)),
            ),
      
    ));
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap:  () {},
          child: Text('Đăng nhập Face',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: AppThemes.Roboto),),
        ),
       InkWell(
          onTap:  () => Get.toNamed(RouterName.forgotpass),
          child: Text('Quên mật khẩu ?', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: AppThemes.Roboto),),
        ),
        
      ],
    );
  }
}