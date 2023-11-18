import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'assigned_user.g.dart';

@HiveType(typeId: 8)
class AssignedUser {
  const AssignedUser({
    required this.userId,
    required this.fullName,
  });

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;


  factory AssignedUser.fromJson(Map<String, dynamic> json) {
    return AssignedUser(
      userId: json['userId'],
      fullName: json['fullName'],

    );
  }

  factory AssignedUser.fromSnapshot(DocumentSnapshot snap) {
    return AssignedUser(
      userId: snap.data().toString().contains('userId') ? snap.get('userId') : '',
      fullName: snap.data().toString().contains('fullName')
          ? snap['fullName']
          : 'No name',
    );
  }

  factory AssignedUser.fromEntity(AssignedUser user) {
    return AssignedUser(
      userId: user.userId,
      fullName: user.fullName,
    );
  }

  AssignedUser toEntity() {
    return AssignedUser(
      userId: userId,
      fullName: fullName,
    );
  }

}
