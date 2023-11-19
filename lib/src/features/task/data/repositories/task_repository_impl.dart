import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/firestore_task_data_source.dart';
import '../data_sources/local_task_data_source.dart';

class TaskRepositoryImpl extends TaskRepository {
  final LocalTaskDataSource localTaskDataSource;
  final FirestoreTaskDataSource firestoreTaskDataSource;

  TaskRepositoryImpl(
    this.localTaskDataSource,
    this.firestoreTaskDataSource,
  );

  @override
  Future<void> addTask(Task task) async {
    final result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      await firestoreTaskDataSource.addTask(task);
    } else {
      var items = await firestoreTaskDataSource.getTasks();
      await localTaskDataSource.addTask(task);
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    final result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      var items = await firestoreTaskDataSource.getTasks();
      for (final item in items) {
        localTaskDataSource.addTask(item);
      }
      return items;
    } else {
      var items = await firestoreTaskDataSource.getTasks();
      return items;
    }
  }


}
