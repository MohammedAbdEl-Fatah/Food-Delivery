import 'package:food_delivery/core/service/firestore_model.dart';

class UserEntity extends FirestoreModel {
  @override
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String gender;
  final String birthday;
  final DateTime createdAt;
  final String phone;
  final String provider;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.gender,
    required this.birthday,
    required this.createdAt,
    required this.phone,
    required this.provider,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'gender': gender,
      'birthday': birthday,
      'createdAt': createdAt.toIso8601String(),
      'phone': phone,
      'provider': provider,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      gender: map['gender'] ?? '',
      birthday: map['birthday'] ?? '',
      createdAt:
          map['createdAt'] != null
              ? DateTime.parse(map['createdAt'])
              : DateTime.now(),
      phone: map['phone'] ?? '',
      provider: map['provider'] ?? '',
    );
  }
}
