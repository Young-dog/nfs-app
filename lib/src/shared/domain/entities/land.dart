import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Land extends Equatable {
  final String landId;
  final String title;
  final int square;
  final Point coordinates;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Land({
    required this.landId,
    required this.title,
    required this.square,
    required this.coordinates,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'title': title,
      'square': square,
      'coordinates': coordinates,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'updatedAt': Timestamp.fromDate(updatedAt ?? DateTime.now()),
    };
  }

  @override
  List<Object?> get props => [
        landId,
        title,
        title,
        square,
        coordinates,
        createdAt,
        updatedAt,
      ];
}
