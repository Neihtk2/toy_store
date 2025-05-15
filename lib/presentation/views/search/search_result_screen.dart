import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/product_model.dart' hide Image;


class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;
  final RxList<Product> results;

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
        if (results.isEmpty) {
          return const Center(child: Text("Không tìm thấy sản phẩm nào."));
        }

        return ListView.separated(
          itemCount: results.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final product = results[index];
            return ListTile(
              leading: Image.network(product.images!.url, width: 50, height: 50),
              title: Text(product.name),
              subtitle: Text(product.description ?? ''),
              onTap: () {
                // TODO: Navigate to product detail
              },
            );
          },
        );
      }),
    );
  }
}
