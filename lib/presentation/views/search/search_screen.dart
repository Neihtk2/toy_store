import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/watch/watch_responsitory.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var filteredWatch = <Watch>[].obs;
  TextEditingController _searchController = TextEditingController();
  final watch = WatchModel();
  bool _showClearButton = false;
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
        if (_searchController.text.isNotEmpty) {
          searchWatch(_searchController.text);
        } else {
          filteredWatch.clear();
        }
      });
    });
  }

  List<Watch> searchWatch(String query) {
    if (query.isEmpty) {
      filteredWatch.value = WatchModel().watches;
    } else {
      filteredWatch.value =
          watch.watches
              .where(
                (wathch) =>
                    wathch.name.toLowerCase().contains(query.toLowerCase()) ||
                    wathch.brand.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    return filteredWatch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Container(
          height: 40,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm đồng hồ...',
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              suffixIcon:
                  _showClearButton
                      ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                      : IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          // Chức năng tìm kiếm bằng camera
                        },
                      ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  watch.searchHistory.remove(value);
                  watch.searchHistory.insert(0, value);
                  if (watch.searchHistory.length > 10) {
                    watch.searchHistory.removeLast();
                  }
                });
                Get.to(
                  SearchResultsScreen(
                    searchQuery: value,
                    watches: searchWatch(value),
                  ),
                )?.then((_) {
                  setState(() {
                    searchWatch(_searchController.text);
                  });
                });
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed(RouterName.cart);
            },
          ),
        ],
      ),
      body: _buildSearchSuggestions(),
    );
  }

  Widget _buildSearchSuggestions() {
    return Container(
      color: Colors.white,
      child:
          _searchController.text.isEmpty
              ? _buildSearchHistory()
              : Obx(
                () => ListView.builder(
                  itemCount: filteredWatch.length,
                  itemBuilder: (context, index) {
                    final watched = filteredWatch[index];
                    return ListTile(
                      leading: Icon(Icons.watch, color: Colors.blueGrey),
                      title: Text(watched.name),
                      subtitle: Text(watched.brand),
                      onTap: () {
                        setState(() {
                          watch.searchHistory.remove(filteredWatch[index]);
                          watch.searchHistory.insert(
                            0,
                            filteredWatch[index].name,
                          );
                          if (watch.searchHistory.length > 10) {
                            watch.searchHistory.removeLast();
                          }
                        });
                        Get.to(
                          SearchResultsScreen(
                            searchQuery: _searchController.text,
                            watches: searchWatch(filteredWatch[index].name),
                          ),
                        )?.then((_) {
                          setState(() {
                            searchWatch(_searchController.text);
                          });
                        });
                        ;
                      },
                    );
                  },
                ),
              ),
    );
  }

  Widget _buildSearchHistory() {
    return Container(
      color: Colors.grey[50],
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lịch sử tìm kiếm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      watch.searchHistory.clear();
                    });
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            children:
                watch.searchHistory.map((search) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = search;
                        });

                        Get.to(
                          SearchResultsScreen(
                            searchQuery: search,
                            watches: searchWatch(search),
                          ),
                        )?.then((_) {
                          setState(() {
                            searchWatch(_searchController.text);
                          });
                        });
                        ;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(search, style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  );
                }).toList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Xu hướng tìm kiếm',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: watch.popularSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.trending_up, color: Colors.blueGrey[800]),
                title: Text(watch.popularSearches[index]),
                trailing: Icon(Icons.north_east, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _searchController.text = watch.popularSearches[index];

                    // Thêm vào lịch sử tìm kiếm
                    watch.searchHistory.remove(watch.popularSearches[index]);
                    watch.searchHistory.insert(0, watch.popularSearches[index]);
                    if (watch.searchHistory.length > 10) {
                      watch.searchHistory.removeLast();
                    }
                  });
                  Get.to(
                    SearchResultsScreen(
                      searchQuery: watch.popularSearches[index],
                      watches: searchWatch(watch.popularSearches[index]),
                    ),
                  )?.then((_) {
                    setState(() {
                      searchWatch(_searchController.text);
                    });
                  });
                  ;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;
  final List<Watch> watches;
  SearchResultsScreen({required this.searchQuery, required this.watches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết quả tìm kiếm: $searchQuery',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Điều hướng đến giỏ hàng
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                watches.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Không tìm thấy đồng hồ phù hợp',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                    : GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: watches.length,
                      itemBuilder: (context, index) {
                        return _buildWatchSearchResult(watches[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchSearchResult(Watch watch) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Icon(Icons.watch, size: 80, color: Colors.blueGrey[800]),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    watch.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800]!.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          watch.brand,
                          style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      if (watch.isFavorite)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[700]!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            'Yêu thích',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${_formatCurrency(watch.price)} VNĐ',
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '${watch.rating}',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Đã bán ${watch.soldCount}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        watch.origin,
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          '-${watch.discountPercent}%',
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
