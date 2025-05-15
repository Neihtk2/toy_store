import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';

class ApiService extends Get.GetxService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: MyConfig.BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  Future<Response> LoginApp(String email, String password) async {
    return await dio.post(
      Endpoints.login,
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> addProduct(String id, String amount,String token) async {
    return await dio.post(
      Endpoints.addProducts,
      data: {
        "products": [
          {"id": id, "amount": amount},
        ],
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );
  }

  Future<Response> registerApp(
    String name,
    String email,
    String password,
    String gender,
    String address,
  ) async {
    return await dio.post(
      Endpoints.register,
      data: {
        'username': name,
        'email': email,
        'password': password,
        'gender': gender,
        'address': address,
      },
    );
  }

  Future<Response> getCart(String token) async {
    return await dio.get(
      Endpoints.getCart,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );

  }

  Future<Response> getMe(String token) async {
    return await dio.get(
      Endpoints.getMe,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );
  }
   Future<Response> getOrder(String token) async {
    return await dio.get(
      Endpoints.getOrder,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );
  }
  

  Future<Response> getProducts(String token) async {
    return await dio.get(
      Endpoints.getProducts,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // Truyền token vào header
        },
      ),
    );
  }
}
