import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String lastName;
  final String firstName;
  final String? middleName;
  final String employeeId;
  final String position;
  final String role;
  final String rfidId;

  const User({
    required this.userId,
    required this.lastName,
    required this.firstName,
    this.middleName,
    required this.employeeId,
    required this.position,
    required this.role,
    required this.rfidId,
  });

  static const empty = User(
    userId: 'user_1',
    lastName: 'Иванов',
    firstName: 'Иван',
    middleName: 'Ивнович',
    employeeId: 'employee_1',
    position: 'Зам директора',
    role: 'агроном',
    rfidId: '123',
  );

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'lastName': lastName,
      'firstName': firstName,
      'middleName': middleName,
      'employeeId': employeeId,
      'position': position,
      'role': role,
      'rfidId': rfidId,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        lastName,
        firstName,
        middleName,
        employeeId,
        position,
        role,
        rfidId,
      ];
}
