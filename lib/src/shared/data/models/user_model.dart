import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

// part 'user_model.g.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime? createdAt;
  final DateTime? lastModified;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.createdAt,
    this.lastModified,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      lastModified: json['lastModified'].toDate(),
      imageUrl: json['imageUrl'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.get('id'),
      email: snap.data().toString().contains('email') ? snap['email'] : 'No Email',
      name: snap.data().toString().contains('name') ? snap['name'] : 'No Name',
      createdAt: snap.data().toString().contains('createdAt') ? snap['createdAt'].toDate() : null,
      lastModified: snap.data().toString().contains('lastModified') ? snap['lastModified'].toDate() : null,
      imageUrl: snap.data().toString().contains('imageUrl') ? snap.get('imageUrl') : null,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      createdAt: user.createdAt,
      lastModified: user.lastModified,
      imageUrl: user.imageUrl,
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      createdAt: createdAt,
      lastModified: lastModified,
      imageUrl: imageUrl,
    );
  }
}

