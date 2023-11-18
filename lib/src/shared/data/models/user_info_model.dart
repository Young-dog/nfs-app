import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_info.dart';

part 'user_info_model.g.dart';

@HiveType(typeId: 7)
class UserInfoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  UserInfoModel({
    required this.id,
    required this.name,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }

  factory UserInfoModel.fromSnapshot(DocumentSnapshot snap) {
    return UserInfoModel(
      id: snap.data().toString().contains('id') ? snap.get('id') : '',
      name: snap.data().toString().contains('name')
          ? snap['name']
          : 'No name',
    );
  }

  factory UserInfoModel.fromEntity(UserInfo userInfo) {
    return UserInfoModel(
      id: userInfo.id,
      name: userInfo.name,
    );
  }

  UserInfo toEntity() {
    return UserInfo(
      id: id,
      name: name,
    );
  }
}
