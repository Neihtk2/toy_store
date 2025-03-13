// import 'package:flutter/material.dart';
// import 'package:toyland_mobile/data/models/cart_model.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final List<CartItem> cartItems = [
//     CartItem(
//       name: 'Nike Club Max',
//       size: 'L',
//       price: 64.95,
//       color: Colors.blue,
//     ),
//     CartItem(
//       name: 'Nike Air Max 200',
//       size: 'XL',
//       price: 64.95,
//       color: Colors.orange,
//     ),
//     CartItem(
//       name: 'Nike Air Max',
//       size: 'XXL',
//       price: 64.95,
//       color: Colors.purple,
//     ),
//   ];

//   double get subtotal =>
//       cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
//   double get shipping => 40.90;
//   double get total => 1690.99; // Using the value from the image for accuracy

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//           style: IconButton.styleFrom(backgroundColor: Colors.white),
//         ),
//         title: const Text(
//           'My Cart',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return CartItemWidget(
//                   item: item,
//                   onQuantityChanged: (newQuantity) {
//                     setState(() {
//                       item.quantity = newQuantity;
//                     });
//                   },
//                   onRemove: () {
//                     setState(() {
//                       cartItems.removeAt(index);
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.35,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//               ),
//               color: Colors.white,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 OrderSummary(
//                   subtotal: subtotal,
//                   shipping: shipping,
//                   total: total,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4795DE),
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     child: const Text(
//                       'Checkout',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CartItemWidget extends StatelessWidget {
//   final CartItem item;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;
//   const CartItemWidget({
//     Key? key,
//     required this.item,
//     required this.onQuantityChanged,
//     required this.onRemove,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       height: 80,
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Shoe icon/image
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: item.color.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(Icons.directions_run, color: item.color, size: 28),
//           ),
//           const SizedBox(width: 16),
//           // Item details
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   '\$${item.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (item.quantity > 1) {
//                           onQuantityChanged(item.quantity - 1);
//                         }
//                       },
//                       icon: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(Icons.remove, color: Colors.grey, size: 16),
//                       ),
//                       style: IconButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.zero,
//                         tapTargetSize:
//                             MaterialTapTargetSize.shrinkWrap, // 🔥 Tắt padding
//                       ),
//                       constraints: BoxConstraints(),
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       '${item.quantity}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     IconButton(
//                       onPressed: () {
//                         onQuantityChanged(item.quantity + 1);
//                       },
//                       icon: const Icon(
//                         Icons.add_circle,
//                         color: Color(0xFF4795DE),
//                         size: 32,
//                       ),

//                       style: IconButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.zero,
//                         tapTargetSize:
//                             MaterialTapTargetSize.shrinkWrap, // 🔥 Tắt padding
//                       ),
//                       constraints: BoxConstraints(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   item.size,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 constraints: BoxConstraints(),
//                 icon: const Icon(Icons.delete_outline, color: Colors.grey),
//                 style: IconButton.styleFrom(
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 onPressed: onRemove,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OrderSummary extends StatelessWidget {
//   final double subtotal;
//   final double shipping;
//   final double total;

//   const OrderSummary({
//     Key? key,
//     required this.subtotal,
//     required this.shipping,
//     required this.total,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Subtotal',
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//               Text(
//                 '\$${subtotal.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Shipping',
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//               Text(
//                 '\$${shipping.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Total Cost',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 '\$${total.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/views/cart/cart_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString paymentMethod = 'vnpay'.obs;
  double get subtotal => 1650.00;
  double get shipping => 40.90;
  double get total => 1690.99;
  double get delivery => 0;
  late KeyboardVisibilityController _keyboardVisibilityController;
  bool _isKeyboardVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Về giỏ hàng',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: CheckoutForm()),
          if (!_isKeyboardVisible)
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
                    delivery: delivery,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4795DE),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Thanh Toán',
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

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({Key? key}) : super(key: key);

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();

  // Để điều khiển trạng thái mở rộng của các mục
  bool _isContactInfoExpanded = true;
  bool _isDeliveryMethodExpanded = false;
  bool _isPaymentMethodExpanded = false;
  late TextEditingController _nameController;
  late TextEditingController _andressController;
  late TextEditingController _phoneController;
  // Lưu trữ dữ liệu form
  // String _name = '';
  // String _phoneNumber = '';
  // String _address = '';
  String _deliveryMethod = 'SAME_DAY';
  String _paymentMethod = 'COD';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _andressController.dispose();
    super.dispose();
  }

  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _andressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1. Contact Information
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                ),
                padding: const EdgeInsets.all(4),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: _isContactInfoExpanded,
                    title: const Text(
                      '1. Thông tin liên hệ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _isContactInfoExpanded = expanded;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Tên người nhận',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[300] ?? Colors.grey,
                                  ),
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Số điện thoại người nhận',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _andressController,
                              decoration: InputDecoration(
                                labelText: 'Địa chỉ người nhận',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              // 2. Delivery Method
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                ),
                padding: const EdgeInsets.all(4),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: _isDeliveryMethodExpanded,
                    title: const Text(
                      '2. Phương thức giao hàng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _isDeliveryMethodExpanded = expanded;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Wrap(
                          spacing: 8,
                          children: [
                            ChoiceChip(
                              label: const Text('SAME_DAY'),
                              selected: _deliveryMethod == 'SAME_DAY',
                              onSelected: (bool selected) {
                                setState(() {
                                  _deliveryMethod = 'SAME_DAY';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: const Text('EXPRESS'),
                              selected: _deliveryMethod == 'EXPRESS',
                              onSelected: (bool selected) {
                                setState(() {
                                  _deliveryMethod = 'EXPRESS';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: const Text('NORMAL'),
                              selected: _deliveryMethod == 'NORMAL',
                              onSelected: (bool selected) {
                                setState(() {
                                  _deliveryMethod = 'NORMAL';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              // 3. Payment Method
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                ),
                padding: const EdgeInsets.all(4),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: _isPaymentMethodExpanded,
                    title: const Text(
                      '3. Phương thức thanh toán',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _isPaymentMethodExpanded = expanded;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _paymentMethod = 'COD';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _paymentMethod == 'COD'
                                          ? Colors.blue
                                          : Colors.grey,
                                ),
                                child: const Text('COD'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _paymentMethod = 'NCB';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _paymentMethod == 'NCB'
                                          ? Colors.blue
                                          : Colors.grey,
                                ),
                                child: const Text('NCB'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     // Xử lý khi nhấn nút Submit
              //     if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();

              //       // In ra dữ liệu để kiểm tra
              //       debugPrint('Name: $_name');
              //       debugPrint('Phone: $_phoneNumber');
              //       debugPrint('Address: $_address');
              //       debugPrint('Delivery Method: $_deliveryMethod');
              //       debugPrint('Payment Method: $_paymentMethod');

              //       // Tại đây, bạn có thể gửi dữ liệu lên server, chuyển trang,...
              //     }
              //   },
              //   child: const Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
