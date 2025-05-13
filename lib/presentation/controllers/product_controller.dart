import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/watch/watch_responsitory.dart';

class ProductController extends GetxController {
  final WatchResponsitory _repo = Get.find();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList<WatchModel> filteredProductItem = <WatchModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    error.value = '';

    String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      isLoading.value = false;
      return;
    }

    try {
      print("🔹 Đang gọi API lấy danh sách sản phẩm...");
      var fetchedCartData = await _repo.getProductItems(token);

      if (fetchedCartData.isNotEmpty) {
        //print("✅ Sản phẩm lấy được: ${fetchedCartData.length} items");
        filteredProductItem.assignAll(fetchedCartData);
      } else {
        print("⚠️ Không có sản phẩm nào!");
        error.value = "Không có sản phẩm!";
      }
    } catch (e) {
      print("❌ Lỗi khi tải sản phẩm: $e");
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
