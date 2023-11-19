import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';

import '../../../../shared/data/models/task_model.dart';
import '../../../../shared/domain/entities/task.dart';


abstract class LocalTaskDataSource {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
}

class LocalTaskDataSourceImpl extends LocalTaskDataSource {
  final _box = Hive.box('tasks');

  Future<Box> _getBox() async {
    return _box;
  }

  @override
  Future<void> addTask(Task task) async {
    await Connectivity().checkConnectivity().then((value) async {
      if (value != ConnectivityResult.mobile &&
          value != ConnectivityResult.wifi) {
        await _box.put(task.landId, TaskModel.fromEntity(task));
      }
    });
  }

  @override
  Future<List<Task>> getTasks() async {
    Box<TaskModel> box = await _getBox() as Box<TaskModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }

}
