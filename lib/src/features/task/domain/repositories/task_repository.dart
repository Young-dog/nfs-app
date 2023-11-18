import 'package:app/src/shared/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  // TODO: getTasksByQuery (поиск)
}