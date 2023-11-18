import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String? middleName;
  @HiveField(4)
  final String employeeId;
  @HiveField(5)
  final String position;
  @HiveField(6)
  final String role;
  @HiveField(7)
  final String rfidId;

  UserModel({
    required this.userId,
    required this.lastName,
    required this.firstName,
    this.middleName,
    required this.employeeId,
    required this.position,
    required this.role,
    required this.rfidId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      employeeId: json['employeeId'],
      position: json['position'],
      role: json['role'],
      rfidId: json['rfidId'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      userId: snap.data().toString().contains('userId') ? snap.get('userId') : '',
      lastName: snap.data().toString().contains('lastName')
          ? snap['lastName']
          : 'No lastName',
      firstName: snap.data().toString().contains('firstName')
          ? snap['firstName']
          : 'No firstName',
      middleName: snap.data().toString().contains('middleName')
          ? snap['middleName']
          : 'No middleName',
      employeeId: snap.data().toString().contains('employeeId')
          ? snap['employeeId']
          : 'No employeeId',
      position: snap.data().toString().contains('position')
          ? snap['position']
          : 'No position',
      role: snap.data().toString().contains('role') ? snap['role'] : 'No role',
      rfidId: snap.data().toString().contains('rfidId')
          ? snap['rfidId']
          : 'No rfidId',
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      userId: user.userId,
      lastName: user.lastName,
      firstName: user.firstName,
      middleName: user.middleName,
      employeeId: user.employeeId,
      position: user.position,
      role: user.role,
      rfidId: user.rfidId,
    );
  }

  User toEntity() {
    return User(
      userId: userId,
      lastName: lastName,
      firstName: firstName,
      middleName: middleName,
      employeeId: employeeId,
      position: position,
      role: role,
      rfidId: rfidId,
    );
  }
}
