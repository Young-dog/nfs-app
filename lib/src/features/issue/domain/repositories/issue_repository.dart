import 'package:app/src/shared/domain/entities/issue.dart';

abstract class IssueRepository {
  Future<List<Issue>> getIssues();
  Future<void> addIssue(Issue issue);
  // TODO: getIssuesByQuery (поиск)
}