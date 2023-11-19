import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  const Issue({
    required this.issueId,
    required this.state,
    required this.title,
    required this.description,

    this.createdAt,
    this.updatedAt,
    this.closedAt,
    required this.createdBy,
    this.assignedTo,
  });

  final String issueId;
  final String state;
  final String title;
  final String description;
  final UserInfo createdBy;
  final UserInfo? assignedTo;
  final DateTime? closedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toDocument() {
    return {
      'issueId': issueId,
      'state': state,
      'title': title,
      'description': description,
      'createdBy': {
        'id': createdBy.id,
        'name': createdBy.name,
      },
      'assignedTo': assignedTo != null ? {
        'id': assignedTo!.id,
        'name': assignedTo!.name,
      } : null,
      'closedAt': closedAt != null ? Timestamp.fromDate(closedAt!) : null,
      'createdAt':  createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt':  updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
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
