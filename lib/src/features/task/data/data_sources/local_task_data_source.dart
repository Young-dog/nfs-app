import 'package:hive/hive.dart';

import '../../../../shared/data/models/task_model.dart';
import '../../../../shared/domain/entities/task.dart';


abstract class LocalTaskDataSource {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
}

class LocalTaskDataSourceImpl extends LocalTaskDataSource {
  Future<Box> _openBox() async {
    return Hive.openBox<TaskModel>('tasks');
  }

  @override
  Future<void> addTask(Task task) async {
    Box box = await _openBox();
    await box.put(task.taskId, TaskModel.fromEntity(task));
  }

  @override
  Future<List<Task>> getTasks() async {
    Box<TaskModel> box = await _openBox() as Box<TaskModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }

}
