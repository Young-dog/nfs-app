import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'assigned_user_model.g.dart';

@HiveType(typeId: 8)
class AssignedUserModel {
  const AssignedUserModel({
    required this.userId,
    required this.fullName,
  });

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;


  factory AssignedUserModel.fromJson(Map<String, dynamic> json) {
    return AssignedUserModel(
      userId: json['userId'],
      fullName: json['fullName'],

    );
  }

  factory AssignedUserModel.fromSnapshot(DocumentSnapshot snap) {
    return AssignedUserModel(
      userId: snap.data().toString().contains('userId') ? snap.get('userId') : '',
      fullName: snap.data().toString().contains('fullName')
          ? snap['fullName']
          : 'No name',
    );
  }

  factory AssignedUserModel.fromEntity(AssignedUserModel user) {
    return AssignedUserModel(
      userId: user.userId,
      fullName: user.fullName,
    );
  }

  AssignedUserModel toEntity() {
    return AssignedUserModel(
      userId: userId,
      fullName: fullName,
    );
  }

}
