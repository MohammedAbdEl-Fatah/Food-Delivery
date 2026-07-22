import 'package:food_delivery/core/service/firestore_model.dart';

class ProductEntity implements FirestoreModel {
  @override
  final String id;
  final String title;
  final String description;
  final num price;
  final String category;
  final String? urlImage;
  final num rating;
  final List<dynamic> avgCookingTime;
  final num avgRating;
  // final bool isFavorite;
  final bool isDelivered;
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
