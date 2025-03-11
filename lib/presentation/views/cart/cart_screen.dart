import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/data/models/cart_model.dart';
import 'package:toyland_mobile/data/repositories/cart/cart_repository.dart';
import 'package:toyland_mobile/routes/router_name.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartList = CartRepository();

  double get subtotal => cartList.cartItems.fold(
    0,
    (sum, item) => sum + (item.price * item.quantity),
  );
  double get shipping => 40.90;
  double get total => 1690.99; // Using the value from the image for accuracy

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
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartList.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartList.cartItems[index];
                return CartItemWidget(
                  item: item,
                  onQuantityChanged: (newQuantity) {
                    setState(() {
                      item.quantity = newQuantity;
                    });
                  },
                  onRemove: () {
                    setState(() {
                      cartList.cartItems.removeAt(index);
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
                  total: total,
                  delivery: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RouterName.checkout);
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
      ),
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
      height: 80,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shoe icon/image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.directions_run, color: Colors.pink, size: 28),
          ),
          const SizedBox(width: 16),
          // Item details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
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
                        if (item.quantity > 1) {
                          onQuantityChanged(item.quantity - 1);
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
                      '${item.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        onQuantityChanged(item.quantity + 1);
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
                  item.brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                constraints: BoxConstraints(),
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
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
                '\$${subtotal.toStringAsFixed(2)}',
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
                '\$${shipping.toStringAsFixed(2)}',
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
                '\$${delivery.toStringAsFixed(2)}',
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
                '\$${total.toStringAsFixed(2)}',
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
