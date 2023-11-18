import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String taskId;
  final String title;
  final String description;
  final String landId;
  final UserInfo createdBy;
  final UserInfo? assignedTo;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.landId,
    required this.createdBy,
    this.assignedTo,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toDocument() {
    return {
      'taskId': taskId,
      'title': title,
      'description': description,
      'landId': landId,
      'createdBy': {
        'id': createdBy.id,
        'name': createdBy.name,
      },
      'assignedTo': assignedTo != null ? {
        'id': assignedTo?.id,
        'name': assignedTo?.name,
      } : null,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'updatedAt': Timestamp.fromDate(updatedAt ?? DateTime.now()),
    };
  }

  @override
  List<Object?> get props => [
        taskId,
        title,
        description,
        landId,
        createdBy,
      assignedTo,
        status,
        createdAt,
        updatedAt,
      ];
}
