class Watch {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final double rating;
  final int soldCount;
  final bool isFavorite;
  final String origin;
  final int discountPercent;

  Watch({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.soldCount,
    required this.isFavorite,
    required this.origin,
    required this.discountPercent,
  });
}