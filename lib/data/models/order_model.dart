import 'dart:convert';

class OrderModel {
  final int id;
  final String status;
  final String address;
  final String phone;
  final String? note;
  final String totalPrice;
  final int totalAmount;
  final String receiver;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Discount discount;
  final User user;
  final List<OrderDetail> orderDetails;

  OrderModel({
    required this.id,
    required this.status,
    required this.address,
    required this.phone,
    this.note,
    required this.totalPrice,
    required this.totalAmount,
    required this.receiver,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
    required this.user,
    required this.orderDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"] as int? ?? 0,
      status: json["status"] ?? '',
      address: json["address"] ?? '',
      phone: json["phone"] ?? '',
      note: json["note"], // Có thể null
      totalPrice: json["totalPrice"] ?? '0',
      totalAmount: json["totalAmount"] as int? ?? 0,
      receiver: json["receiver"] ?? '',
      paymentType: json["paymentType"] ?? '',
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),
      discount: Discount.fromJson(json["discount"] ?? {}),
      user: User.fromJson(json["user"] ?? {}),
      orderDetails: (json["orderDetails"] as List?)
              ?.map((x) => OrderDetail.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "address": address,
      "phone": phone,
      "note": note,
      "totalPrice": totalPrice,
      "totalAmount": totalAmount,
      "receiver": receiver,
      "paymentType": paymentType,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "discount": discount.toJson(),
      "user": user.toJson(),
      "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    };
  }
}

class Discount {
  final int? id;
  final int? percent;
  final String? price;

  Discount({this.id, this.percent, this.price});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      id: json["id"] as int?,
      percent: json["percent"] as int?,
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "percent": percent,
        "price": price,
      };
}

class User {
  final int id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int? ?? 0,
      username: json["username"] ?? '',
      email: json["email"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
      };
}

class OrderDetail {
  final int amount;
  final int productId;
  final int unitPrice;
  final String productName;

  OrderDetail({
    required this.amount,
    required this.productId,
    required this.unitPrice,
    required this.productName,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      amount: json["amount"] as int? ?? 0,
      productId: json["productId"] as int? ?? 0,
      unitPrice: json["unitPrice"] as int? ?? 0,
      productName: json["productName"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "productId": productId,
        "unitPrice": unitPrice,
        "productName": productName,
      };
}
