import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/unit.dart';

part 'unit_model.g.dart';

@HiveType(typeId: 9)

class UnitModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? depth;
  @HiveField(2)
  final String? consumptionSolution;

  const UnitModel({
    required this.name,
    this.depth,
    this.consumptionSolution,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      name: json['name'],
      depth: json['depth'],
      consumptionSolution: json['consumptionSolution'],

    );
  }

  factory UnitModel.fromSnapshot(DocumentSnapshot snap) {
    return UnitModel(
      name: snap.data().toString().contains('name') ? snap.get('name') : '',
      depth: snap.data().toString().contains('depth')
          ? snap['depth']
          : '',
      consumptionSolution: snap.data().toString().contains('consumptionSolution')
          ? snap['consumptionSolution']
          : '',
    );
  }

  factory UnitModel.fromEntity(Unit unit) {
    return UnitModel(
      name: unit.name,
      depth: unit.depth,
      consumptionSolution: unit.consumptionSolution,
    );
  }

  Unit toEntity() {
    return Unit(
      name: name,
      depth: depth,
      consumptionSolution: consumptionSolution,
    );
  }

}
