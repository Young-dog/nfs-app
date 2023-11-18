import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String taskId;
  final String title;
  final String description;
  final String landId;
  final String creatorId;
  final String executorId;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.landId,
    required this.creatorId,
    required this.executorId,
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
      'creatorId': creatorId,
      'executorId': executorId,
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
        creatorId,
        executorId,
        status,
        createdAt,
        updatedAt,
      ];
}
