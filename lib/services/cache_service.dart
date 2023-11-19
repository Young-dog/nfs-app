import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../src/features/land/data/data_sources/firestore_land_data_source.dart';
import '../src/shared/data/models/land_model.dart';

class CacheService {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final FirestoreLandDataSourceImpl _firestoreLandDataSource;

  CacheService({
    required FirestoreLandDataSourceImpl firestoreLandDataSource,
  }) : _firestoreLandDataSource = firestoreLandDataSource;

  final String _tasksBoxName = 'tasks';
  final String _landsBoxName = 'lands';
  final String _issuesBoxName = 'issues';
  final String _vehiclesBoxName = 'vehicles';

  late Box _tasksBox;
  late Box _landsBox;
  late Box _issuesBox;
  late Box _vehiclesBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _tasksBox = await Hive.openBox(_tasksBoxName);
    _landsBox = await Hive.openBox(_landsBoxName);
    _issuesBox = await Hive.openBox(_issuesBoxName);
    _vehiclesBox = await Hive.openBox(_vehiclesBoxName);

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {

        debugPrint('--> Got Internet');

        await _sendCachedData();
      }
    });
  }


  Future<void> _sendCachedData() async {
    final List<dynamic> cachedLands =
        List<dynamic>.from(_landsBox.values.toList());

    if (cachedLands.isNotEmpty) {
      for (var land in cachedLands) {
        try {
          await _firestoreLandDataSource.addLand(land.toEntity());
        } catch (e, s) {
          debugPrintStack(
            label: '$e',
            stackTrace: s,
          );
        }
      }
      // Once the data is sent successfully, you can clear the cache
      await _landsBox.clear();
    }
  }

  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
    await _landsBox.close();
  }
}
