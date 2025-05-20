import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/product_model.dart';

import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/watch/toy_responsitory.dart';


class ToysController extends GetxController {
  final ToyReponsitoryImpl _repo = ToyReponsitoryImpl.instance;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final RxList<WatchModel> allProduct = <WatchModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    getToys();
  }

  Future<void> refreshDishes() async {
    await getToys();
  }

  Future<void> getToys() async {
    try {
      isLoading.value = true;
      allProduct.value = await _repo.getToys();
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchDishById(String id) async {
  //   try {
  //     isLoading.value = true;
  //     dish.value = await _repo.getDishedbyId(id);
  //   } catch (e) {
  //     Get.snackbar("Lỗi", "Không thể tải món ăn");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}

void _handleError(dynamic e) {
  final message =
      e is DioException
          ? e.response?.data['message'] ?? e.message
          : e.toString();
  // Get.snackbar('Error', message);

}

