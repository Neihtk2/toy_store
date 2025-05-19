import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/core/constants/endpoint.dart';
import 'package:toyland_mobile/data/models/like_model.dart';


class LikeController extends GetxController {
  final Dio _dio = Dio();
  final RxInt totalLikes = 0.obs;
  final RxBool isLiked = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<int> likedProductIds = <int>[].obs;
  final RxList<LikeModel> likedProducts = <LikeModel>[].obs;

  final String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
  bool hasFetchedFavorites = false;

  /// Gọi một lần duy nhất khi vào homepage
  Future<void> preloadFavoriteProductIds() async {
    if (hasFetchedFavorites || token == null) return;

    try {
      final response = await _dio.get(
        '${MyConfig.BASE_URL}${Endpoints.getLike}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final favorites = response.data['data']['favorites'] as List;
        likedProductIds.assignAll(
          favorites.map<int>((e) => e['productId'] as int).toList(),
        );
        hasFetchedFavorites = true;
      } else {
        print('Lỗi preload: Mã trạng thái ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi preload favorites: $e');
    }
  }

  /// Gọi API để lấy chi tiết các sản phẩm đã thích
  Future<void> fetchLikedProductsDetail() async {
    if (token == null) return;

    try {
      final response = await _dio.get(
        '${MyConfig.BASE_URL}${Endpoints.getLike}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final favorites = response.data['data']['favorites'] as List;
        likedProducts.assignAll(
          favorites.map((e) => LikeModel.fromJson(e)).toList(),
        );
      } else {
        print('Lỗi lấy danh sách sản phẩm đã thích: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi fetchLikedProductsDetail: $e');
    }
  }

  /// Toggle like và cập nhật danh sách đã like (Optimistic UI)
  Future<void> toggleLike(int productId) async {
    if (isLoading.value || token == null) return;

    isLoading.value = true;
    final wasLiked = likedProductIds.contains(productId);

    // Optimistic UI update
    if (wasLiked) {
      likedProductIds.remove(productId);
      totalLikes.value = (totalLikes.value > 0) ? totalLikes.value - 1 : 0;
    } else {
      likedProductIds.add(productId);
      totalLikes.value += 1;
    }

    try {
      final response = await _dio.post(
        '${MyConfig.BASE_URL}${Endpoints.getLike}',
        data: {'productId': productId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Toggle failed with status ${response.statusCode}');
      }
    } catch (e) {
      // Rollback UI if failed
      if (wasLiked) {
        likedProductIds.add(productId);
        totalLikes.value += 1;
      } else {
        likedProductIds.remove(productId);
        totalLikes.value = (totalLikes.value > 0) ? totalLikes.value - 1 : 0;
      }
      print('Lỗi khi toggle like: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Dùng khi vào trang chi tiết sản phẩm
  bool isProductLiked(int productId) {
    return likedProductIds.contains(productId);
  }
}
