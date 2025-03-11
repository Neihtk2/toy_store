// lib/presentation/views/auth/login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/controllers/auth_controller.dart';
import 'package:toyland_mobile/routes/router_name.dart';
import 'package:toyland_mobile/x_res/app_themes.dart';


class ForgotpassScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
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
                Center(child: RichText(
    text: TextSpan(
      text: 'Bạn đã có tài khoản? ',
      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16.sp, fontFamily: AppThemes.Roboto), // Màu mặc định cho văn bản
      children: [
        TextSpan(
          text: 'Đăng nhập',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: AppThemes.Roboto), // Màu nhấn cho Sign Up
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.offNamed(RouterName.login), 
        ),
      ],
    ),
  ),),
                 SizedBox(height: 30.h),
                 Center(
                  child: Text(
                    'QUÊN MẬT KHẨU',
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                  ),
                ),
                  SizedBox(height: 30.h),
                 Text(
                  'Email*',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,fontFamily: AppThemes.Roboto),
                ),
                 SizedBox(height: 20.h),
                _buildEmailField(),
                 
                
                 
                 SizedBox(height: 30.h),
                _buildForgotButton()
               
                
              ],
            ),
          ),
        ));
     
    
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



  Widget _buildForgotButton() {
    return Obx(() => InkWell(
      onTap: controller.isLoading.value
          ? null
          : () => controller.forgotpass(
            _emailController.text.trim(),   
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
                  :  Center(child: Text('XÁC THỰC EMAIL',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.white),)),
            ),
      
    ));
  }

}