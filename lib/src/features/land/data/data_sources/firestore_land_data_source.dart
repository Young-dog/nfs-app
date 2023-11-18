import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../../shared/data/models/land_model.dart';
import '../../../../shared/domain/entities/land.dart';

abstract class FirestoreLandDataSource {
  Future<List<Land>> getLands();
  Future<void> addLand(Land land);
}

class FirestoreLandDataSourceImpl extends FirestoreLandDataSource {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreLandDataSourceImpl({
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Future<List<Land>> getLands() {
    return _firebaseFirestore
        .collection('lands')
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return LandModel.fromSnapshot(doc).toEntity();
      }).toList();
    });
  }


  @override
  Future<void> addLand(Land land) async {
    var ref = _firebaseFirestore.collection('lands');
    await ref.add(land.toDocument()).then((doc) {
      var docId = doc.id;
      ref.doc(docId).update({
        'id': docId,
      });
    });


    debugPrint('Записан в firestore');

  }

}
