import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'assigned_user.dart';
import 'unit.dart';

class Vehicle extends Equatable {
  const Vehicle({
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

  final String name;
  final String vehicleId;
  final AssignedUser createdBy;
  final AssignedUser? assignedTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String operation;
  final String workingSpeed;
  final Unit? unit;


  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'vehicleId': vehicleId,
      'createdBy':createdBy,
      'assignedTo':assignedTo,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'updatedAt': Timestamp.fromDate(updatedAt ?? DateTime.now()),
      'operation':operation,
      'workingSpeed':workingSpeed,
      'unit':unit,
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
