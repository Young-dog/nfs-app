import 'package:app/src/shared/domain/entities/assigned_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  const Issue({
    required this.issueId,
    required this.state,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.closedAt,
    this.assignedTo,
  });

  final String issueId;
  final String state;
  final String title;
  final String description;
  final AssignedUser createdBy;
  final AssignedUser? assignedTo;
  final DateTime? closedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toDocument() {
    return {
      'issueId': issueId,
      'state': state,
      'title': title,
      'description': description,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
      'closedAt': closedAt != null ? Timestamp.fromDate(closedAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  @override
  List<Object?> get props => [
        issueId,
        state,
        title,
        description,
        createdBy,
        assignedTo,
        closedAt,
        createdAt,
        updatedAt,
      ];
}
