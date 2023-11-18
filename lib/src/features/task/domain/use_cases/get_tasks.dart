import 'package:app/src/shared/domain/entities/task.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';

import '../repositories/task_repository.dart';

class GetTasks extends UseCase<List<Task>, NoParams> {
  final TaskRepository landRepository;

  GetTasks(this.landRepository);
  @override
  Future<List<Task>> call(NoParams params) {
    return landRepository.getTasks();
  }

}