import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';

class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;
  final RxList<WatchModel> results;

  const SearchResultsScreen({
    required this.searchQuery,
    required this.results,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kết quả: "$searchQuery"')),
      body: Obx(() {
        return results.isEmpty
            ? const Center(child: Text("Không tìm thấy sản phẩm nào."))
            : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 9,
                mainAxisSpacing: 8,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final watch = results[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ToyDetailScreen(watch: watch));
                  },
                  child: WatchCard(watch: watch),
                );
              },
            );
      }),
    );
  }
}
