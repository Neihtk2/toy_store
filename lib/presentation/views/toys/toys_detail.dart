import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';
import 'package:toyland_mobile/presentation/controllers/like_controller.dart';

class ToyDetailScreen extends StatefulWidget {
  final WatchModel watch;

  const ToyDetailScreen({Key? key, required this.watch}) : super(key: key);

  @override
  _ToyDetailScreenState createState() => _ToyDetailScreenState();
}

class _ToyDetailScreenState extends State<ToyDetailScreen> {
  int currentIndex = 0;
  bool isFavorite = false;
  int quantity = 1;
  late double totalPrice;
  bool isLoading = false;
  late final CartController cartController;
  late final CartRepository cartRepository;
  late final likeController = Get.put(LikeController());

  @override
  void initState() {
    super.initState();
    totalPrice = double.parse(widget.watch.price);
    cartController = Get.put(CartController());
    likeController.preloadFavoriteProductIds();
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      totalPrice = double.parse(widget.watch.price) * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSlider(),
                    const SizedBox(height: 20),
                    _buildProductInfo(),
                    const SizedBox(height: 20),
                    _buildQuantitySelector(quantity, _updateQuantity),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        "Watch Store",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            child: PageView.builder(
              itemCount: widget.watch.images.length,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemBuilder: (context, index) {
                return Image.network(
                  widget.watch.images[index].url,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.watch.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 12 : 8,
                  height: currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Bán chạy",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            _buildFavoriteButton(widget.watch.id),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          widget.watch.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          NumberFormat("#,###.###", "en_US")
              .format(double.parse(widget.watch.price)),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.watch.description ?? "",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton(int productId) {
    return Obx(() {
      final isLiked = likeController.isProductLiked(productId);

      return IconButton(
        icon: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () => likeController.toggleLike(productId),
      );
    });
  }

  Widget _buildQuantitySelector(int quantity, Function(int) onQuantityChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Số lượng",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            _buildQuantityButton(Icons.remove, () {
              if (quantity > 1) onQuantityChanged(quantity - 1);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildQuantityButton(Icons.add, () {
              onQuantityChanged(quantity + 1);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.black54),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Giá",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Text(
                NumberFormat("#,###.###", "en_US").format(totalPrice),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: isLoading ? null : _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Thêm vào giỏ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart() async {
    setState(() => isLoading = true);
    try {
      await cartRepository.postProducts(
        widget.watch.id,
        quantity,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Lỗi khi thêm vào giỏ hàng!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    setState(() => isLoading = false);
  }
}
