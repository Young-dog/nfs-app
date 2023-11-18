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
  final String creatorId;
  @HiveField(5)
  final String executorId;
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
    required this.creatorId,
    required this.executorId,
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
      creatorId: json['creatorId'],
      executorId: json['executorId'],
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
      creatorId: snap.data().toString().contains('creatorId')
          ? snap['creatorId']
          : 'No creatorId',
      executorId: snap.data().toString().contains('executorId')
          ? snap['executorId']
          : 'No executorId',
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
      creatorId: task.creatorId,
      executorId: task.executorId,
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
      creatorId: creatorId,
      executorId: executorId,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
