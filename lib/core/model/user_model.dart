import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/firestore_model.dart';

class UserModel extends FirestoreModel {
  @override
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int age;
  final String gender;
  final String birthday;
  final DateTime createdAt;
  final String? phone;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.age,
    required this.gender,
    required this.birthday,
    required this.createdAt,
    this.phone,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl ?? "",
      'age': age,
      'gender': gender,
      'birthday': birthday,
      'createdAt': createdAt.toIso8601String(),
      'phone': phone ?? "",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final dynamic createdAtRaw = map['createdAt'];
    DateTime createdAt;
    if (createdAtRaw is Timestamp) {
      createdAt = createdAtRaw.toDate();
    } else if (createdAtRaw is String) {
      createdAt = DateTime.tryParse(createdAtRaw) ?? DateTime.now();
    } else {
      createdAt = DateTime.now();
    }

    return UserModel(
      id: (map['id'] ?? map['userID'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      photoUrl: map['photoUrl'] as String?,
      age: (map['age'] ?? 0) is int ? (map['age'] ?? 0) as int : 0,
      gender: (map['gender'] ?? '') as String,
      birthday: (map['birthday'] ?? '') as String,
      createdAt: createdAt,
      phone: map['phone'] as String?,
    );
  }
}
