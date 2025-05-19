class WatchModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String price;
  final String sold;
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
    required this.sold,
    required this.stockAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.branch,
    required this.category,
    required this.images,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) {
    return WatchModel(
      id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? '',
      slug: json["slug"] ?? '',
      description: json["description"],
      price: json["price"]?.toString() ?? '0',
      salePrice: json["salePrice"]?.toString(),
      sold: json["sold"]?.toString() ?? '0',
      stockAmount: json["stockAmount"]?.toString() ?? '0',
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),
      branch: Branch.fromJson(json["branch"] ?? {}),
      category: Category.fromJson(json["category"] ?? {}),
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
      "sold": sold,
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
      id: int.tryParse(json["id"].toString()) ?? 0,
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
      id: int.tryParse(json["id"].toString()) ?? 0,
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
      id: int.tryParse(json["id"].toString()) ?? 0,
      url: json["url"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
