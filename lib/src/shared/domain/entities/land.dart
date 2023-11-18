import 'dart:math';

import 'package:equatable/equatable.dart';

class Land extends Equatable {
  final String landId;
  final String title;
  final int square;
  final Point coordinates;

  const Land({
    required this.landId,
    required this.title,
    required this.square,
    required this.coordinates,
  });


  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'title': title,
      'square': square,
      'coordinates': coordinates,
    };
  }

  @override
  List<Object?> get props => [
    landId,
        title,
        title,
        square,
        coordinates,
      ];
}
