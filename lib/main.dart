// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';
import 'package:toyland_mobile/routes/pages.dart';
import 'package:toyland_mobile/routes/router_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo dependencies
  await Get.putAsync(() => SharedPreferences.getInstance());
  await Get.putAsync(() => ApiService().init());
  Get.lazyPut(() => AuthRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouterName.search,
          getPages: Pages.pages,
        );
      },
    );
  }
}
//Size(1080, 2400)