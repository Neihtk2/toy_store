import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:toyland_mobile/presentation/views/home/toy_item.dart';
import 'package:toyland_mobile/presentation/views/search/search_controller.dart';
import 'package:toyland_mobile/presentation/views/search/search_result_screen.dart';
import 'package:toyland_mobile/presentation/views/toys/toys_detail.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchToysController controller = Get.put(SearchToysController());

  List<String> searchHistory = [];
  List<String> popularSearches = ['Robo Car', 'Teddy Bear', 'Puzzle Box'];
  bool _showClearButton = false;

  void _onSearch(String query) {
    if (query.isEmpty) return;
    // Cập nhật lịch sử
    searchHistory.remove(query);
    searchHistory.insert(0, query);
    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }
    controller.searchToy(query);
    Get.to(
      () => SearchResultsScreen(
        searchQuery: query,
        results: controller.filteredDishes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(child: _buildSuggestions()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Nhập tên sản phẩm...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            _showClearButton
                ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _showClearButton = false;
                      controller.filteredDishes.clear();
                    });
                  },
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: (value) {
        setState(() {
          _showClearButton = value.isNotEmpty;
        });
        controller.searchToy(value);
      },
      onSubmitted: _onSearch,
    );
  }

  Widget _buildSuggestions() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return _buildDefaultSuggestions();
    }

    return Obx(() {
      final results = controller.filteredDishes;
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
    });
  }

  Widget _buildDefaultSuggestions() {
    return ListView(
      children: [
        if (searchHistory.isNotEmpty) ...[
          const Text(
            'Lịch sử tìm kiếm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...searchHistory.map(
            (query) => ListTile(
              leading: const Icon(Icons.history),
              title: Text(query),
              onTap: () {
                _searchController.text = query;
                _onSearch(query);
              },
            ),
          ),
          const Divider(),
        ],
        const Text(
          'Tìm kiếm phổ biến',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...popularSearches.map(
          (query) => ListTile(
            leading: const Icon(Icons.trending_up),
            title: Text(query),
            onTap: () {
              _searchController.text = query;
              _onSearch(query);
            },
          ),
        ),
      ],
    );
  }
}