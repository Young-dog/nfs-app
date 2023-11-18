import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String id;
  final String name;

  const UserInfo({
    required this.id,
    required this.name,
  });


  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
