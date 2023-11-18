import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../shared/data/models/task_model.dart';
import '../../../../shared/domain/entities/task.dart';

abstract class FirestoreTaskDataSource {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
}

class FirestoreTaskDataSourceImpl extends FirestoreTaskDataSource {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreTaskDataSourceImpl({
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Future<List<Task>> getTasks() {
    return _firebaseFirestore
        .collection('tasks')
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromSnapshot(doc).toEntity();
      }).toList();
    });
  }


  @override
  Future<void> addTask(Task task) async {
    var ref = _firebaseFirestore.collection('tasks');
    await ref.add(task.toDocument()).then((doc) {
      var docId = doc.id;
      ref.doc(docId).update({
        'id': docId,
      });
    });
  }

}
