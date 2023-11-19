import 'package:app/src/features/task/domain/repositories/task_repository.dart';
import 'package:app/src/shared/domain/entities/task.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';


class AddTask implements UseCase<void, AddTaskParams> {
  final TaskRepository taskRepository;

  AddTask(this.taskRepository);

  @override
  Future<void> call(AddTaskParams params) {
    return taskRepository.addTask(params.task);
  }

}

class AddTaskParams extends Equatable {
  final Task task;

  const AddTaskParams({required this.task});
  @override
  List<Object?> get props => [task];
}