import 'package:app/src/shared/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'assigned_user_model.dart';
import 'land_model.dart';

part 'vehicle_model.g.dart';

@HiveType(typeId: 10)
class VehicleModel {
  const VehicleModel({
    required this.vehicleId,
    required this.createdBy,
    required this.assignedTo,
    required this.name,
    required this.operation,
    required this.workingSpeed,
    required this.unit,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String vehicleId;

  @HiveField(2)
  final AssignedUserModel createdBy;

  @HiveField(3)
  final AssignedUserModel? assignedTo;

  @HiveField(4)
  final DateTime? createdAt;

  @HiveField(5)
  final DateTime? updatedAt;

  @HiveField(6)
  final String operation;

  @HiveField(8)
  final String workingSpeed;

  @HiveField(9)
  final UnitModel? unit;

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      name: json['name'],
      vehicleId: json['vehicleId'],
      createdBy: json['createdBy'],
      assignedTo: json['assignedTo'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
      operation: json['operation'],
      workingSpeed: json['workingSpeed'],
      unit: json['unit'],
    );
  }

  factory VehicleModel.fromSnapshot(DocumentSnapshot snap) {
    return VehicleModel(
      name: snap['name'],
      vehicleId: snap['vehicleId'],
      createdBy: snap['createdBy'],
      assignedTo: snap.data().toString().contains('assignedTo')
          ? snap['assignedTo']
          : null,
      createdAt: snap.data().toString().contains('createdAt')
          ? snap['createdAt'].toDate()
          : null,
      updatedAt: snap.data().toString().contains('updatedAt')
          ? snap['updatedAt'].toDate()
          : null,
      operation:
          snap.data().toString().contains('operation') ? snap['operation'] : '',
      workingSpeed: snap.data().toString().contains('workingSpeed')
          ? snap['workingSpeed']
          : '',
      unit: snap.data().toString().contains('unit')
          ? snap['unit'].toDate()
          : null,
    );
  }

  factory VehicleModel.fromEntity(VehicleModel vehicle) {
    return VehicleModel(
      name: vehicle.name,
      vehicleId: vehicle.vehicleId,
      createdBy: vehicle.createdBy,
      assignedTo: vehicle.assignedTo,
      createdAt: vehicle.createdAt,
      updatedAt: vehicle.updatedAt,
      operation: vehicle.operation,
      workingSpeed: vehicle.workingSpeed,
      unit: vehicle.unit,
    );
  }

  VehicleModel toEntity() {
    return VehicleModel(
      name: name,
      vehicleId: vehicleId,
      createdBy: createdBy,
      assignedTo: assignedTo,
      createdAt: createdAt,
      updatedAt: updatedAt,
      operation: operation,
      workingSpeed: workingSpeed,
      unit: unit,
    );
  }
}
