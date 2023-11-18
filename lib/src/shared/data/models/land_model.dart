import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/land.dart';

part 'land_model.g.dart';

@HiveType(typeId: 1)
class LandModel {
  @HiveField(0)
  final String landId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int square;
  @HiveField(3)
  final Point coordinates;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final DateTime? updatedAt;

  LandModel({
    required this.landId,
    required this.title,
    required this.square,
    required this.coordinates,
    this.createdAt,
    this.updatedAt,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
      landId: json['landId'],
      title: json['title'],
      square: json['square'],
      coordinates: json['coordinates'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  factory LandModel.fromSnapshot(DocumentSnapshot snap) {
    return LandModel(
      landId: snap['landId'],
      title: snap.data().toString().contains('title')
          ? snap['title']
          : 'No title',
      square: snap.data().toString().contains('square')
          ? snap['square']
          : 'No square',
      coordinates: snap.data().toString().contains('coordinates')
          ? snap['coordinates']
          : 'No coordinates',
      createdAt: snap.data().toString().contains('createdAt')
          ? snap['createdAt'].toDate()
          : null,
      updatedAt: snap.data().toString().contains('updatedAt')
          ? snap['updatedAt'].toDate()
          : null,
    );
  }

  factory LandModel.fromEntity(Land land) {
    return LandModel(
      landId: land.landId,
      title: land.title,
      square: land.square,
      coordinates: land.coordinates,
    );
  }

  Land toEntity() {
    return Land(
      landId: landId,
      title: title,
      square: square,
      coordinates: coordinates,
    );
  }
}
