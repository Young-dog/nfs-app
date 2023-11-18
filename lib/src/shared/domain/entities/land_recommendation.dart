import 'package:equatable/equatable.dart';

class LandRecommendation extends Equatable {
  final String landId;
  final String recommendationId;

  const LandRecommendation({
    required this.landId,
    required this.recommendationId,
  });

  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'recommendationId': recommendationId,
    };
  }

  @override
  List<Object?> get props => [
        landId,
        recommendationId,
      ];
}
