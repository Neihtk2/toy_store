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
   bool isRating;
  final ProductModel? product;

  OrderDetail({
    required this.amount,
    required this.productId,
    required this.unitPrice,
    required this.productName,
    required this.isRating,
    this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      amount: json["amount"] ?? 0,
      productId: json["productId"] ?? 0,
      unitPrice: json["unitPrice"] ?? 0,
      productName: json["productName"] ?? '',
      isRating: json["isRating"] ?? false,
      product: json["product"] != null ? ProductModel.fromJson(json["product"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "productId": productId,
        "unitPrice": unitPrice,
        "productName": productName,
        "isRating": isRating,
        "product": product?.toJson(),
      };
}
class ProductModel {
  final int id;
  final int categoryId;
  final int branchId;
  final int? shopifyId;
  final int? shopBaseId;
  final String name;
  final String description;
  final int price;
  final int? salePrice;
  final int stockAmount;
  final int sold;
  final String? type;
  final String slug;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductImage> images;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.branchId,
    this.shopifyId,
    this.shopBaseId,
    required this.name,
    required this.description,
    required this.price,
    this.salePrice,
    required this.stockAmount,
    required this.sold,
    this.type,
    required this.slug,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['categoryId'],
      branchId: json['branchId'],
      shopifyId: json['shopifyId'],
      shopBaseId: json['shopBaseId'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      salePrice: json['salePrice'],
      stockAmount: json['stockAmount'] ?? 0,
      sold: json['sold'] ?? 0,
      type: json['type'],
      slug: json['slug'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: (json['images'] as List<dynamic>?)
              ?.map((img) => ProductImage.fromJson(img))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "branchId": branchId,
        "shopifyId": shopifyId,
        "shopBaseId": shopBaseId,
        "name": name,
        "description": description,
        "price": price,
        "salePrice": salePrice,
        "stockAmount": stockAmount,
        "sold": sold,
        "type": type,
        "slug": slug,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": images.map((e) => e.toJson()).toList(),
      };
}

class ProductImage {
  final int id;
  final int productId;
  final String url;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImage({
    required this.id,
    required this.productId,
    required this.url,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['productId'],
      url: json['url'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "url": url,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

