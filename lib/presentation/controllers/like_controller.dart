import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';

class LikeController extends GetxController {
  final Dio _dio = Dio();
  final RxInt totalLikes = 0.obs; // Rx để hiển thị trong Obx
  String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);

  RxBool isLiked = false.obs;
  final RxBool isLoading = false.obs;

  Future<void> toggleLike(int productId) async {
  if (isLoading.value) return; // Tránh gọi liên tiếp
  isLoading.value = true;

  bool previousState = isLiked.value;
  int previousTotal = totalLikes.value;

  isLiked.value = !previousState;
  totalLikes.value += isLiked.value ? 1 : -1;

  try {
    final response = await _dio.post(
      '${MyConfig.BASE_URL}${Endpoints.getLike}',
      data: {"productId": productId},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      await fetchFavoriteByProductId(productId);
    } else {
      isLiked.value = previousState;
      totalLikes.value = previousTotal;
    }
  } catch (e) {
    isLiked.value = previousState;
    totalLikes.value = previousTotal;
    print('Lỗi khi toggle like: $e');
  } finally {
    isLoading.value = false;
  }
}


  Future<void> fetchFavoriteByProductId(int productId) async {
  isLoading.value = true;
  try {
    final response = await _dio.get(
      '${MyConfig.BASE_URL}${Endpoints.getLike}',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      totalLikes.value = data['total'] ?? 0;

      final favorites = List<Map<String, dynamic>>.from(data['favorites'] ?? []);
      isLiked.value = favorites.any((fav) => fav['productId'] == productId);
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  } catch (e) {
    print('Lỗi khi gọi API: $e');
  } finally {
    isLoading.value = false;
  }
}

}
