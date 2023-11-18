import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../shared/data/models/issue_model.dart';
import '../../../../shared/domain/entities/issue.dart';

abstract class FirestoreIssueDataSource {
  Future<List<Issue>> getIssues();
  Future<void> addIssue(Issue issue);
}

class FirestoreIssueDataSourceImpl extends FirestoreIssueDataSource {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreIssueDataSourceImpl({
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Future<List<Issue>> getIssues() {
    return _firebaseFirestore
        .collection('issues')
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return IssueModel.fromSnapshot(doc).toEntity();
      }).toList();
    });
  }


  @override
  Future<void> addIssue(Issue issue) async {
    var ref = _firebaseFirestore.collection('issues');
    await ref.add(issue.toDocument()).then((doc) {
      var docId = doc.id;
      ref.doc(docId).update({
        'id': docId,
      });
    });
  }

}
