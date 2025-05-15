class Product {
  int id;
  String name;
  String slug;
  String? description;
  String price;
  dynamic salePrice;
  String stockAmount;
  String sold;
  String? shopifyId;
  String? shopBaseId;
  DateTime createdAt;
  DateTime updatedAt;
  Branch branch;
  Branch category;
  Image images;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.salePrice,
    required this.stockAmount,
    required this.sold,
    required this.shopifyId,
    required this.shopBaseId,
    required this.createdAt,
    required this.updatedAt,
    required this.branch,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    price: json["price"],
    salePrice: json["salePrice"],
    stockAmount: json["stockAmount"],
    sold: json["sold"],
    shopifyId: json["shopifyId"],
    shopBaseId: json["shopBaseId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    branch: Branch.fromJson(json["branch"]),
    category: Branch.fromJson(json["category"]),
    images: Image.fromJson(json["images"][0]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "price": price,
    "salePrice": salePrice,
    "stockAmount": stockAmount,
    "sold": sold,
    "shopifyId": shopifyId,
    "shopBaseId": shopBaseId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branch": branch.toJson(),
    "category": category.toJson(),
  };
}

class Branch {
  int id;
  String name;
  Branch({required this.id, required this.name});
  factory Branch.fromJson(Map<String, dynamic> json) =>
      Branch(id: json["id"], name: json["name"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Image {
  int id;
  String url;

  Image({required this.id, required this.url});

  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(id: json["id"], url: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "url": url};
}