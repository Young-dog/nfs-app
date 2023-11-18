import 'package:app/src/shared/data/models/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 6)
class TaskModel {
  @HiveField(0)
  final String taskId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String landId;


  @HiveField(4)
  final UserInfoModel createdBy;

  @HiveField(5)
  final UserInfoModel? assignedTo;

  @HiveField(6)
  final String status;


  @HiveField(7)
  final DateTime? createdAt;
  @HiveField(8)
  final DateTime? updatedAt;


  TaskModel({
    required this.taskId,
    required this.title,
    required this.description,
    required this.landId,
    required this.createdBy,
    this.assignedTo,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      landId: json['landId'],
      createdBy: UserInfoModel.fromJson(json['createdBy']),
      assignedTo: UserInfoModel.fromJson(json['assignedTo']),
      status: json['status'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  factory TaskModel.fromSnapshot(DocumentSnapshot snap) {
    return TaskModel(
      taskId: snap.data().toString().contains('taskId') ? snap.get('taskId') : '',
      title: snap.data().toString().contains('title')
          ? snap['title']
          : 'No title',
      description: snap.data().toString().contains('description')
          ? snap['description']
          : 'No description',
      landId: snap.data().toString().contains('landId')
          ? snap['landId']
          : 'No landId',
      createdBy: UserInfoModel.fromSnapshot(snap['createdBy']),
      assignedTo: snap.data().toString().contains('assignedTo')
          ? UserInfoModel.fromSnapshot(snap['assignedTo'])
          : null,
      status: snap.data().toString().contains('status') ? snap['status'] : 'No status',
      createdAt: snap.data().toString().contains('createdAt')
          ? snap['createdAt'].toDate()
          : null,
      updatedAt: snap.data().toString().contains('updatedAt')
          ? snap['updatedAt'].toDate()
          : null,
    );
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      taskId: task.taskId,
      title: task.title,
      description: task.description,
      landId: task.landId,
      createdBy: UserInfoModel.fromEntity(task.createdBy),
      assignedTo: task.assignedTo != null ? UserInfoModel.fromEntity(task.assignedTo!) : null,
      status: task.status,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
    );
  }

  Task toEntity() {
    return Task(
      taskId: taskId,
      title: title,
      description: description,
      landId: landId,
      createdBy: createdBy.toEntity(),
      assignedTo: assignedTo != null ? assignedTo!.toEntity() : null,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
