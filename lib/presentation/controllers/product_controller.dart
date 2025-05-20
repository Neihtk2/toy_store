import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/watch/watch_responsitory.dart';

class ProductController extends GetxController {
  final WatchResponsitory _repo = WatchResponsitory();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final RxList<WatchModel> allProducts = <WatchModel>[].obs; // Thêm dòng này
  final RxList<WatchModel> filteredProductItem = <WatchModel>[].obs;

  final RxString selectedBranch = ''.obs;

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
        print("✅ Sản phẩm lấy được: ${fetchedCartData.length} items");
        allProducts.assignAll(fetchedCartData);
        filteredProductItem.assignAll(
          fetchedCartData,
        ); // Ban đầu hiển thị tất cả
      } else {
        error.value = "Không có sản phẩm!";
      }
    } catch (e) {
      error.value = "Lỗi khi tải giỏ hàng: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void filterByBranch(String branchName) {
    if (selectedBranch.value == branchName) {
      // Nếu chọn lại cùng 1 branch => reset về tất cả
      selectedBranch.value = '';
      filteredProductItem.assignAll(allProducts);
    } else {
      selectedBranch.value = branchName;
      filteredProductItem.assignAll(
        allProducts.where((product) => product.branch?.name == branchName),
      );
    }
  }
}
