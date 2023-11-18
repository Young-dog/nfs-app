import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/land_recommendation.dart';

part 'land_recommendation_model.g.dart';

@HiveType(typeId: 4)
class LandRecommendationModel {
  @HiveField(0)
  final String landId;
  @HiveField(1)
  final String recommendationId;

  LandRecommendationModel({
    required this.landId,
    required this.recommendationId,
  });

  factory LandRecommendationModel.fromJson(Map<String, dynamic> json) {
    return LandRecommendationModel(
      landId: json['landId'],
      recommendationId: json['recommendationId'],
    );
  }

  factory LandRecommendationModel.fromSnapshot(DocumentSnapshot snap) {
    return LandRecommendationModel(
      landId: snap['landId'],
      recommendationId: snap['recommendationId'],
    );
  }

  factory LandRecommendationModel.fromEntity(LandRecommendation recommendation) {
    return LandRecommendationModel(
      landId: recommendation.landId,
      recommendationId: recommendation.title,
    );
  }

  LandRecommendation toEntity() {
    return LandRecommendation(
      landId: landId,
      recommendationId: recommendationId,
    );
  }
}
