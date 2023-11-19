import 'package:app/src/shared/domain/entities/unit.dart';
import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


class Vehicle extends Equatable {
  final String name;
  final String vehicleId;
  final UserInfo createdBy;
  final UserInfo? assignedTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String operation;
  final String workingSpeed;
  final Unit? unit;

  const Vehicle({
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


  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'vehicleId': vehicleId,
      'createdBy': {
        'id': createdBy.id,
        'name': createdBy.id,
      },
      'assignedTo': assignedTo != null ? {
        'id': assignedTo!.id,
        'name': assignedTo!.id,
      } : null,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'updatedAt': Timestamp.fromDate(updatedAt ?? DateTime.now()),
      'operation':operation,
      'workingSpeed':workingSpeed,
      'unit': unit != null ? {
        'name': unit!.name,
        'depth': unit!.depth,
        'consumptionSolution': unit!.consumptionSolution,
      } : null,
    };
  }

  @override
  List<Object?> get props =>
      [
        name,
        vehicleId,
        createdBy,
        assignedTo,
        createdAt,
        updatedAt,
        operation,
        workingSpeed,
        unit,
      ];


}
