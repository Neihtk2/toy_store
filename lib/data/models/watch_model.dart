import 'dart:convert';

class WatchModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String price;
  final String? salePrice;
  final String stockAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Branch branch;
  final Category category;
  final List<ProductImage> images;

  WatchModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.price,
    this.salePrice,
    required this.stockAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.branch,
    required this.category,
    required this.images,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) {
    return WatchModel(
      id: json["id"] as int? ?? 0,
      name: json["name"] ?? '',
      slug: json["slug"] ?? '',
      description: json["description"], // Có thể null
      price: json["price"] ?? '0',
      salePrice: json["salePrice"], // Có thể null
      stockAmount: json["stockAmount"] ?? '0',
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),
      branch: Branch.fromJson(json["branch"] ?? {}), // Nếu null thì truyền {}
      category: Category.fromJson(json["category"] ?? {}), // Nếu null thì truyền {}
      images: (json["images"] as List?)
              ?.map((x) => ProductImage.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "price": price,
      "salePrice": salePrice,
      "stockAmount": stockAmount,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "branch": branch.toJson(),
      "category": category.toJson(),
      "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
  }
}

class Branch {
  final int id;
  final String name;

  Branch({required this.id, required this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json["id"] as int? ?? 0,
      name: json["name"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] as int? ?? 0,
      name: json["name"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductImage {
  final int id;
  final String url;

  ProductImage({required this.id, required this.url});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json["id"] as int? ?? 0,
      url: json["url"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
