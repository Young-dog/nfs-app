import 'package:app/src/shared/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/vehicle.dart';
import '../../domain/entities/unit.dart' as u;
import 'user_info_model.dart';

part 'vehicle_model.g.dart';

@HiveType(typeId: 10)
class VehicleModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String vehicleId;

  @HiveField(2)
  final UserInfoModel createdBy;

  @HiveField(3)
  final UserInfoModel? assignedTo;

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


  const VehicleModel({
    required this.vehicleId,
    required this.createdBy,
    this.assignedTo,
    required this.name,
    required this.operation,
    required this.workingSpeed,
    this.unit,
    this.createdAt,
    this.updatedAt,
  });


  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      name: json['name'],
      vehicleId: json['vehicleId'],
      createdBy: UserInfoModel.fromJson(json['createdBy']),
      assignedTo: json['assignedTo'] != null ? UserInfoModel.fromJson(json['assignedTo']) : null,
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
      operation: json['operation'],
      workingSpeed: json['workingSpeed'],
      unit: json['unit'] != null ? UnitModel.fromJson(json['unit']) : null,
    );
  }

  factory VehicleModel.fromSnapshot(DocumentSnapshot snap) {
    return VehicleModel(
      name: snap['name'],
      vehicleId: snap['vehicleId'],
      createdBy: UserInfoModel.fromSnapshot(snap['createdBy']),
      assignedTo: snap.data().toString().contains('assignedTo')
          ? UserInfoModel.fromSnapshot(snap['assignedTo'])
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
          ? UnitModel.fromSnapshot(snap['unit'])
          : null,
    );
  }

  factory VehicleModel.fromEntity(Vehicle vehicle) {
    return VehicleModel(
      name: vehicle.name,
      vehicleId: vehicle.vehicleId,
      createdBy: UserInfoModel.fromEntity(vehicle.createdBy),
      assignedTo: vehicle.assignedTo != null ? UserInfoModel.fromEntity(vehicle.assignedTo!) : null,
      createdAt: vehicle.createdAt,
      updatedAt: vehicle.updatedAt,
      operation: vehicle.operation,
      workingSpeed: vehicle.workingSpeed,
      unit: vehicle.unit != null ? UnitModel.fromEntity(vehicle.unit!) : null,
    );
  }

  Vehicle toEntity() {
    return Vehicle(
      name: name,
      vehicleId: vehicleId,
      createdBy: createdBy.toEntity(),
      assignedTo: assignedTo != null ? assignedTo!.toEntity() : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      operation: operation,
      workingSpeed: workingSpeed,
      unit: unit != null ? unit!.toEntity() : null,
    );
  }
}
