import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/core/network/api_service.dart';
import 'package:toyland_mobile/data/models/product_model.dart';

abstract class ToyReponsitory {
  Future<List<Product>> getToys();
}

class ToyReponsitoryImpl implements ToyReponsitory {
  final ApiService api = Get.find();
  final box = GetStorage();
  static final ToyReponsitoryImpl _instance = ToyReponsitoryImpl._internal();
  ToyReponsitoryImpl._internal();
  static ToyReponsitoryImpl get instance => _instance;
  @override
  Future<List<Product>> getToys() async {
    final token = box.read(MyConfig.ACCESS_TOKEN);
    try {
      final response = await api.dio.get(
        Endpoints.getProducts,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final dishes = _handleResponse(response);
      return dishes;
    } on DioException catch (e) {
      _handleError(e);
      return [];
    }
  }
}

List<Product> _handleResponse(Response response) {
  if (response.statusCode != 200 && response.statusCode != 201) return [];
  try {
    final List<dynamic> jsonList = response.data["data"]["products"];
    return jsonList.map((json) => Product.fromJson(json)).toList();
  } catch (e) {
    throw const FormatException('Invalid user data format');
  }
}

void _handleError(dynamic error) {
  if (error is DioException) {
    Get.snackbar('Error', error.response?.data['message'] ?? error.message);
  } else {
    Get.snackbar('Error', error.toString());
  }
}