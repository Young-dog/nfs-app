import 'package:app/src/shared/data/models/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'issue_model.g.dart';

@HiveType(typeId: 11)
class IssueModel {
  const IssueModel({
    required this.issueId,
    required this.state,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.assignedTo,
    this.closedAt,
  });

  @HiveField(0)
  final String issueId;
  @HiveField(1)
  final String state;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final UserInfoModel createdBy;
  @HiveField(5)
  final UserInfoModel? assignedTo;
  @HiveField(6)
  final DateTime? closedAt;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final DateTime updatedAt;

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issueId'],
      state: json['state'],
      title: json['title'],
      description: json['description'],
      createdBy: json['createdBy'],
      assignedTo: json['assignedTo'],
      closedAt: json['closedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  factory IssueModel.fromSnapshot(DocumentSnapshot snap) {
    return IssueModel(
      issueId: snap['issueId'],
      state: snap['state'],
      title: snap['title'],
      description: snap['description'],
      createdBy: snap['createdBy'],
      assignedTo: snap.data().toString().contains('assignedTo')
          ? snap['assignedTo']
          : null,
      closedAt: snap.data().toString().contains('closedAt')
          ? snap['closedAt']
          : null,
      createdAt: snap['createdAt'],
      updatedAt: snap['updatedAt'],
    );
  }

  factory IssueModel.fromEntity(IssueModel issue) {
    return IssueModel(
      issueId: issue.issueId,
      state: issue.state,
      title: issue.title,
      description: issue.description,
      createdBy: issue.createdBy,
      assignedTo: issue.assignedTo,
      closedAt: issue.closedAt,
      createdAt: issue.createdAt,
      updatedAt: issue.updatedAt,
    );
  }

  IssueModel toEntity() {
    return IssueModel(
      issueId: issueId,
      state: state,
      title: title,
      description: description,
      createdBy: createdBy,
      assignedTo: assignedTo,
      closedAt: closedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
