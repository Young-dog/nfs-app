import 'package:equatable/equatable.dart';

class AssignedUser extends Equatable{
  const AssignedUser({
    required this.userId,
    required this.fullName,
  });

  final String userId;
  final String fullName;

  static const empty = AssignedUser(
    userId: 'user_1',
    fullName: 'Иванов Иван Иванович',
  );

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'fullName': fullName,
    };
  }

  @override
  List<Object?> get props => [
    userId,
    fullName,
  ];

}
