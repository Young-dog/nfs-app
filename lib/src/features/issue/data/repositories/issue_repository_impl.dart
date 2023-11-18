import '../../../../shared/domain/entities/issue.dart';
import '../../domain/repositories/issue_repository.dart';
import '../data_sources/firestore_issue_data_source.dart';
import '../data_sources/local_issue_data_source.dart';

class IssueRepositoryImpl extends IssueRepository {
  final LocalIssueDataSource localIssueDataSource;
  final FirestoreIssueDataSource firestoreIssueDataSource;

  IssueRepositoryImpl(
    this.localIssueDataSource,
    this.firestoreIssueDataSource,
  );

  @override
  Future<void> addIssue(Issue issue) async {

    // TODO: отправить запрос на проверку интернета

    // TODO: кладем в local - await localIssueDataSource.addIssue(issue);

    // TODO: Если есть инет: то отправляем в firestore - await firestoreIssueDataSource.addIssue(issue);


    // return appConfig.environment == 'local'
    //     ? await localIssueDataSource.addIssue(issue)
    //     : await firestoreIssueDataSource.addIssue(issue);
    return await firestoreIssueDataSource.addIssue(issue);
  }

  @override
  Future<List<Issue>> getIssues() async {
    // var items = appConfig.environment == 'local'
    //     ? await mockIssueDataSource.getIssues()
    //     : await firestoreIssueDataSource.getIssues(type);
    return await firestoreIssueDataSource.getIssues();

    // if ((await localIssueDataSource.getIssues()).isEmpty) {
    //   var items = appConfig.environment == 'local'
    //       ? await mockIssueDataSource.getIssues()
    //       : await firestoreIssueDataSource.getIssues();
    //   for (final item in items) {
    //     localIssueDataSource.addIssue(item);
    //   }
    //   return items;
    // } else {
    //   debugPrint('Getting categories from Hive');
    //   return localIssueDataSource.getIssues();
    // }
  }


}
