import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/land_soil_condition.dart';

part 'land_soil_condition_model.g.dart';

@HiveType(typeId: 3)
class LandSoilConditionModel {
  @HiveField(0)
  final String conditionId;
  @HiveField(1)
  final String landId;
  @HiveField(2)
  final String type;

  LandSoilConditionModel({
    required this.landId,
    required this.conditionId,
    required this.type,
  });

  factory LandSoilConditionModel.fromJson(Map<String, dynamic> json) {
    return LandSoilConditionModel(
      landId: json['landId'],
      conditionId: json['conditionId'],
      type: json['type'],
    );
  }

  factory LandSoilConditionModel.fromSnapshot(DocumentSnapshot snap) {
    return LandSoilConditionModel(
      landId: snap['landId'],
      conditionId: snap['conditionId'],
      type: snap['type'],
    );
  }

  factory LandSoilConditionModel.fromEntity(LandSoilCondition condition) {
    return LandSoilConditionModel(
      landId: condition.landId,
      conditionId: condition.conditionId,
      type: condition.type,
    );
  }

  LandSoilCondition toEntity() {
    return LandSoilCondition(
      landId: landId,
      conditionId: conditionId,
      type: type,
    );
  }
}
