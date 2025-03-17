import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';
import 'package:toyland_mobile/presentation/controllers/cart_controller.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find<CartController>();
  double get shipping => 40.90;
  double get subtotal => cartController.filteredCartItem.fold(
    0,
    (sum, item) => sum + (item.price * item.amount),
  );
  double get delivery => 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
          style: IconButton.styleFrom(backgroundColor: Colors.white),
        ),
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (!cartController.isLoading.value &&
            cartController.filteredCartItem.isEmpty) {
          return Center(child: Text('Không có sản phẩm nào'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.filteredCartItem.length,
                itemBuilder: (context, index) {
                  final item = cartController.filteredCartItem[index];
                  return CartItemWidget(
                    item: item,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        item.amount = newQuantity;
                      });
                    },
                    onRemove: () {
                      setState(() {
                        cartController.filteredCartItem.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OrderSummary(
                    subtotal: subtotal,
                    shipping: shipping,
                    total: subtotal + shipping,
                    delivery: delivery,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          RouterName.checkout,
                          arguments: {
                            'subtotal': subtotal,
                            'shipping': shipping,
                            'total': subtotal + shipping,
                            'delivery': delivery,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4795DE),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 160,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shoe icon/image
          Container(
            width: 100,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          // Item details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item.amount > 1) {
                          onQuantityChanged(item.amount - 1);
                        }
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.remove, color: Colors.grey, size: 16),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 🔥 Tắt padding
                      ),
                      constraints: BoxConstraints(),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${item.amount}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        onQuantityChanged(item.amount + 1);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF4795DE),
                        size: 32,
                      ),

                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 🔥 Tắt padding
                      ),
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.productId.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                constraints: BoxConstraints(),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double total;
  final double delivery;
  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.delivery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${formartted(subtotal)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${formartted(shipping)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                '\$${formartted(delivery)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Cost',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${formartted(total)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formartted(num number) {
  String formattedPrice = NumberFormat("#,##0.00").format(number);
  return formattedPrice;
}
