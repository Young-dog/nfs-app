import 'package:hive/hive.dart';

import '../../../../shared/data/models/issue_model.dart';
import '../../../../shared/domain/entities/issue.dart';


abstract class LocalIssueDataSource {
  Future<List<Issue>> getIssues();
  Future<void> addIssue(Issue issue);
}

class LocalIssueDataSourceImpl extends LocalIssueDataSource {
  Future<Box> _openBox() async {
    return Hive.openBox<IssueModel>('issues');
  }

  @override
  Future<void> addIssue(Issue issue) async {
    Box box = await _openBox();
    await box.put(issue.issueId, IssueModel.fromEntity(issue));
  }

  @override
  Future<List<Issue>> getIssues() async {
    Box<IssueModel> box = await _openBox() as Box<IssueModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }

}
