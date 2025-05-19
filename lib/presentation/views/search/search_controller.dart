import 'package:diacritic/diacritic.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/product_model.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';

import 'package:toyland_mobile/presentation/controllers/toy_controller.dart';

class SearchToysController extends GetxController {
  final ToysController repo = Get.find();
  final RxList<WatchModel> filteredDishes = <WatchModel>[].obs;
  final RxList<String> suggestions = <String>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();

    filteredDishes.assignAll(repo.allProduct);
  }

  void searchToy(String query) {
    searchQuery.value = query;
    final normalizedQuery = removeDiacritics(query.toLowerCase().trim());
    if (normalizedQuery.isEmpty) {
      filteredDishes.assignAll(repo.allProduct);
      suggestions.clear();
      return;
    }

    final results =
        repo.allProduct.where((dish) {
          final name = removeDiacritics(dish.name!.toLowerCase());
          final category = removeDiacritics(
            (dish.category?.name)!.toLowerCase(),
          );

          return name.contains(normalizedQuery) ||
              category.contains(normalizedQuery);
        }).toList();

    filteredDishes.assignAll(results);

    final sugg =
        repo.allProduct
            .where(
              (dish) => removeDiacritics(
                dish.name!.toLowerCase(),
              ).startsWith(normalizedQuery),
            )
            .map((dish) => dish.name)
            .toSet()
            .toList();
    suggestions.assignAll(sugg as Iterable<String>);
  }
}
