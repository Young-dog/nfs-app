import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/issue.dart';
import 'user_info_model.dart';

part 'issue_model.g.dart';

@HiveType(typeId: 11)
class IssueModel {
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
  final DateTime? createdAt;
  @HiveField(8)
  final DateTime? updatedAt;

  IssueModel({
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

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issueId'],
      state: json['state'],
      title: json['title'],
      description: json['description'],
      closedAt: json['closedAt'] != null ? json['closedAt']!.toDate() : null,
      createdAt: json['createdAt'] != null ? json['createdAt']!.toDate() : null,
      updatedAt: json['updatedAt'] != null ? json['updatedAt']!.toDate() : null,
      createdBy: UserInfoModel.fromJson(json['createdBy']),
      assignedTo: json['assignedTo'] != null ? UserInfoModel.fromJson(json['createdBy']) : null,
    );
  }

  factory IssueModel.fromSnapshot(DocumentSnapshot snap) {
    return IssueModel(
      issueId: snap['issueId'],
      state: snap['state'],
      title: snap['title'],
      description: snap['description'],
      closedAt: snap.data().toString().contains('closedAt')
          ? snap['closedAt'].toDate()
          : null,
      createdAt: snap.data().toString().contains('createdAt')
          ? snap['createdAt'].toDate()
          : null,
      updatedAt: snap.data().toString().contains('updatedAt')
          ? snap['updatedAt'].toDate()
          : null,
      createdBy: UserInfoModel.fromSnapshot(snap['createdBy']),
      assignedTo: snap['assignedTo'] != null ? UserInfoModel.fromSnapshot(snap['assignedTo']) : null,
    );
  }

  factory IssueModel.fromEntity(Issue issue) {
    return IssueModel(
      issueId: issue.issueId,
      title: issue.title,
      state: issue.state,
      description: issue.description,
      assignedTo: issue.assignedTo != null ? UserInfoModel.fromEntity(issue.assignedTo!) : null,
      closedAt: issue.closedAt,
      createdBy: UserInfoModel.fromEntity(issue.createdBy),
      updatedAt: issue.updatedAt,
      createdAt: issue.createdAt,
    );
  }

  Issue toEntity() {
    return Issue(
      issueId: issueId,
      title: title,
      state: state,
      description: description,
      createdBy: createdBy.toEntity(),
      assignedTo: assignedTo != null ? createdBy.toEntity() : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      closedAt: closedAt,
    );
  }
}