import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyland_mobile/core/constants/config.dart';
import 'package:toyland_mobile/data/models/me_models.dart';
import 'package:toyland_mobile/data/models/user_models.dart';
import 'package:toyland_mobile/data/repositories/auth/auth_repository.dart';

class UserController extends GetxController {
  final AuthRepository _repo = Get.find();
  final Rx<MeModel?> user = Rx<MeModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    isLoading.value = true;

    String? token = GetStorage().read(MyConfig.ACCESS_TOKEN);
    if (token == null || token.isEmpty) {
      error.value = "Bạn chưa đăng nhập!";
      isLoading.value = false;
      return;
    }

    try {
      print("🔹 Fetching user with token: $token");

      var fetchedUser = await _repo.getUser(token);
      if (fetchedUser != null) {
        user.value = fetchedUser;
        error.value = '';
        print("✅ User fetched successfully: ${user.value}");
      } else {
        error.value = "Không thể tải thông tin người dùng!";
        print("❌ API trả về null.");
      }
    } catch (e) {
      error.value = "Lỗi khi lấy thông tin người dùng.";
      print("⚠️ Lỗi khi gọi API: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
