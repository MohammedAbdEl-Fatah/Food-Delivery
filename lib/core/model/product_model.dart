import 'package:food_delivery/core/service/firestore_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends HiveObject implements FirestoreModel {
  @override
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final num price;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String? urlImage;
  @HiveField(6)
  final num rating;
  @HiveField(7)
  final List<dynamic> avgCookingTime;
  @HiveField(8)
  final num avgRating;
  // final bool isFavorite;
  @HiveField(9)
  final bool isDelivered;
  @HiveField(10)
  final num priceDelivery;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.urlImage,
    required this.rating,
    required this.avgCookingTime,
    required this.avgRating,
    required this.isDelivered,
    required this.priceDelivery,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': urlImage ?? "",
      'rating': rating,
      'avgCookingTime': avgCookingTime,
      'avgRating': avgRating,
      'isDelivered': isDelivered,
      'priceDelivery': priceDelivery,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: (map['id'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      price: (map['price'] ?? '') as num,
      category: (map['category'] ?? '') as String,
      urlImage: map['urlImage'] as String?,
      rating: (map['rating'] ?? 0) as num,
      avgCookingTime: (map['avgCookingTime'] ?? []) as List<dynamic>,
      avgRating: (map['avgRating'] ?? 0) as num,
      isDelivered: (map['isDelivered'] ?? false) as bool,
      priceDelivery: (map['priceDelivery'] ?? 0) as num,
    );
  }
}
