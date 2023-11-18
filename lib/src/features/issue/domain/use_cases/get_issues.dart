import 'package:app/src/shared/domain/entities/issue.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';

import '../repositories/issue_repository.dart';

class GetIssues extends UseCase<List<Issue>, NoParams> {
  final IssueRepository landRepository;

  GetIssues(this.landRepository);
  @override
  Future<List<Issue>> call(NoParams params) {
    return landRepository.getIssues();
  }

}