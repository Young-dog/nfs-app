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

    await localTaskDataSource.addTask(task).then((value) => debugPrint('---> '));

    Connectivity().checkConnectivity().then((value) async {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        await firestoreTaskDataSource.addTask(task);
      }
    });

  }

  @override
  Future<List<Task>> getTasks() async {
    // var items = appConfig.environment == 'local'
    //     ? await mockTaskDataSource.getTasks()
    //     : await firestoreTaskDataSource.getTasks(type);
    return await firestoreTaskDataSource.getTasks();

    // if ((await localTaskDataSource.getTasks()).isEmpty) {
    //   var items = appConfig.environment == 'local'
    //       ? await mockTaskDataSource.getTasks()
    //       : await firestoreTaskDataSource.getTasks();
    //   for (final item in items) {
    //     localTaskDataSource.addTask(item);
    //   }
    //   return items;
    // } else {
    //   debugPrint('Getting categories from Hive');
    //   return localTaskDataSource.getTasks();
    // }
  }


}
