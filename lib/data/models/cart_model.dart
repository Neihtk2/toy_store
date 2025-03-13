
class CartItem {
  final int orderId;
  final int productId;
  final String productName;
  var amount;
  final int price;
  final String imageUrl;

  CartItem({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.amount,
    required this.price,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      amount: json['amount'],
      price: json['price'],
      imageUrl: json['images'][0]['url'],
    );
  }

}
