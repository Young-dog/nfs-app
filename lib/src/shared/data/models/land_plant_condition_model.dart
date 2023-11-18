import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/land.dart';
import '../../domain/entities/land_plant_condition.dart';

part 'land_plant_condition_model.g.dart';

@HiveType(typeId: 2)
class LandPlantConditionModel {
  @HiveField(0)
  final String conditionId;
  @HiveField(1)
  final String landId;

  LandPlantConditionModel({
    required this.landId,
    required this.conditionId,
  });

  factory LandPlantConditionModel.fromJson(Map<String, dynamic> json) {
    return LandPlantConditionModel(
      landId: json['landId'],
      conditionId: json['conditionId'],
    );
  }

  factory LandPlantConditionModel.fromSnapshot(DocumentSnapshot snap) {
    return LandPlantConditionModel(
      landId: snap['landId'],
      conditionId: snap['conditionId'],
    );
  }

  factory LandPlantConditionModel.fromEntity(LandPlantCondition condition) {
    return LandPlantConditionModel(
      landId: condition.landId,
      conditionId: condition.conditionId,
    );
  }

  LandPlantCondition toEntity() {
    return LandPlantCondition(
      landId: landId,
      conditionId: conditionId,
    );
  }
}
