import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';

class FilterProductScreen extends StatelessWidget {
  final List<WatchModel> products;
  final String title;

  const FilterProductScreen({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF8F9FA),
      ),
      body: products.isEmpty
          ? const Center(child: Text("Không có sản phẩm nào."))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 9,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final watch = products[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ToyDetailScreen(watch: watch));
                  },
                  child: WatchCard(watch: watch),
                );
              },
            ),
    );
  }
}


  
  