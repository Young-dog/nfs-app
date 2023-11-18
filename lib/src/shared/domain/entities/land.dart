import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Land extends Equatable {
  final String landId;
  final String title;
  final int square;
  final List<double> coordinates;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserInfo createdBy;

  const Land({
    required this.landId,
    required this.title,
    required this.square,
    required this.coordinates,
    this.createdAt,
    this.updatedAt,
    required this.createdBy,
  });

  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'title': title,
      'square': square,
      'coordinates': coordinates,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'updatedAt': Timestamp.fromDate(updatedAt ?? DateTime.now()),
      'createdBy': {
        'id': createdBy.id,
        'name' : createdBy.name,
      },
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
        createdBy,
      ];
}
