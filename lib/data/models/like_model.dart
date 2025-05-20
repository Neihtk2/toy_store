import 'package:toyland_mobile/data/models/watch_model.dart';

class LikeModel {
  final int id;
  final int productId;
  final WatchModel product;
  final int userId;
  final DateTime createdAt;

  LikeModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.userId,
    required this.createdAt,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      productId: json['productId'],
      product: WatchModel.fromJson(json['product']),
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
