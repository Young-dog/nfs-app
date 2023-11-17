import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final DateTime? createdAt;
  final DateTime? lastModified;
  final String? imageUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.createdAt,
    this.lastModified,
    this.imageUrl,
  });

  static const empty = User(
    id: '-',
    email: 'test@email.com',
    name: 'TestName',
    createdAt: null,
    lastModified: null,
    imageUrl: null,
  );

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'last_modified': Timestamp.fromDate(lastModified ?? DateTime.now()),
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        createdAt,
        lastModified,
        imageUrl,
      ];
}
