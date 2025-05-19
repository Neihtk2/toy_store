import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:toyland_mobile/presentation/controllers/checkout_controller.dart';
import 'package:toyland_mobile/presentation/views/cart/cart_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final RxString paymentMethod = 'COD'.obs;
  final GlobalKey<CheckoutFormState> _formKey = GlobalKey<CheckoutFormState>();
  late KeyboardVisibilityController _keyboardVisibilityController;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
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
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    double subtotal = arguments['subtotal'] ?? 100000;
    double shipping = arguments['shipping'] ?? 20000;
    double delivery = arguments['delivery'] ?? 0;
    double total = arguments['total'] ?? (subtotal + shipping + delivery);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
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
        children: [
          Expanded(
            child: CheckoutForm(
              key: _formKey,
              onPaymentMethodChanged: (method) {
                paymentMethod.value = method;
              },
            ),
          ),
          if (!_isKeyboardVisible)
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OrderSummary(
                    subtotal: subtotal,
                    shipping: shipping,
                    delivery: delivery,
                    total: total,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed:
                            checkoutController.isLoading.value
                                ? null
                                : () {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!
                                          .validateAndGetData()) {
                                    final data =
                                        _formKey.currentState!.formData;
                                    if (paymentMethod.value == 'COD') {
                                      checkoutController.checkout(
                                        data['phone'],
                                        data['receiver'],
                                        data['address'],
                                        data['note'] ?? '',
                                      );
                                    } else {
                                      checkoutController.checkoutWithVNPay(
                                        data['phone'],
                                        data['receiver'],
                                        data['address'],
                                        data['note'] ?? '',
                                      );
                                    }
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4795DE),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child:
                            checkoutController.isLoading.value
                                ? Center(child: CircularProgressIndicator())
                                : const Text(
                                  'Thanh Toán',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
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
  final Function(String) onPaymentMethodChanged;

  const CheckoutForm({Key? key, required this.onPaymentMethodChanged})
    : super(key: key);

  @override
  State<CheckoutForm> createState() => CheckoutFormState();
}

class CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};
  bool _isContactInfoExpanded = true;
  bool _isDeliveryMethodExpanded = false;
  bool _isPaymentMethodExpanded = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _noteController;

  String _deliveryMethod = 'SAME_DAY';
  String _paymentMethod = 'COD';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool validateAndGetData() {
    if (_formKey.currentState!.validate()) {
      formData['receiver'] = _nameController.text.trim();
      formData['phone'] = _phoneController.text.trim();
      formData['address'] = _addressController.text.trim();
      formData['note'] =
          _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim();
      formData['deliveryMethod'] = _deliveryMethod;
      formData['paymentMethod'] = _paymentMethod;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildExpansionTile(
              title: '1. Thông tin liên hệ',
              initiallyExpanded: _isContactInfoExpanded,
              onExpansionChanged:
                  (expanded) =>
                      setState(() => _isContactInfoExpanded = expanded),
              child: Column(
                children: [
                  buildTextField(
                    controller: _nameController,
                    label: 'Tên người nhận',
                    validatorMsg: 'Vui lòng nhập tên người nhận',
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: _phoneController,
                    label: 'Số điện thoại người nhận',
                    validatorMsg: 'Vui lòng nhập số điện thoại',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: _addressController,
                    label: 'Địa chỉ người nhận',
                    validatorMsg: 'Vui lòng nhập địa chỉ',
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    controller: _noteController,
                    label: 'Ghi chú (tuỳ chọn)',
                    validator: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            buildExpansionTile(
              title: '2. Phương thức giao hàng',
              initiallyExpanded: _isDeliveryMethodExpanded,
              onExpansionChanged:
                  (expanded) =>
                      setState(() => _isDeliveryMethodExpanded = expanded),
              child: Wrap(
                spacing: 8,
                children:
                    ['SAME_DAY', 'EXPRESS', 'NORMAL'].map((type) {
                      return ChoiceChip(
                        label: Text(type),
                        selected: _deliveryMethod == type,
                        onSelected: (_) {
                          setState(() => _deliveryMethod = type);
                        },
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            buildExpansionTile(
              title: '3. Phương thức thanh toán',
              initiallyExpanded: _isPaymentMethodExpanded,
              onExpansionChanged:
                  (expanded) =>
                      setState(() => _isPaymentMethodExpanded = expanded),
              child: Row(
                children: [
                  buildPaymentButton('COD', 'COD'),
                  const SizedBox(width: 16),
                  buildPaymentButton('VNPAY', 'NCB'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionTile({
    required String title,
    required bool initiallyExpanded,
    required Function(bool) onExpansionChanged,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.all(4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onExpansionChanged: onExpansionChanged,
          children: [Padding(padding: const EdgeInsets.all(12), child: child)],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    String? validatorMsg,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator:
          validator ??
          (validatorMsg != null
              ? (value) =>
                  value == null || value.trim().isEmpty ? validatorMsg : null
              : null),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget buildPaymentButton(String label, String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _paymentMethod = value;
            widget.onPaymentMethodChanged(value);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _paymentMethod == value ? Colors.blue : Colors.grey,
        ),
        child: Text(label),
      ),
    );
  }
}

// Giả lập widget OrderSummary
