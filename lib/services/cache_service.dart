import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../src/features/land/data/data_sources/firestore_land_data_source.dart';
import '../src/features/task/data/data_sources/firestore_task_data_source.dart';

class CacheService {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final FirestoreLandDataSourceImpl _firestoreLandDataSource;
  final FirestoreTaskDataSource _firestoreTaskDataSource;

  CacheService({
    required FirestoreLandDataSourceImpl firestoreLandDataSource,
    required FirestoreTaskDataSource firestoreTaskDataSource,
  }) : _firestoreLandDataSource = firestoreLandDataSource,
        _firestoreTaskDataSource = firestoreTaskDataSource;

  final String _tasksBoxName = 'cached_tasks';
  final String _landsBoxName = 'cached_lands';
  final String _issuesBoxName = 'cached_issues';
  final String _vehiclesBoxName = 'cached_vehicles';

  final String _tasksName = 'tasks';
  final String _landsName = 'lands';
  final String _issuesName = 'issues';
  final String _vehiclesName = 'vehicles';

  late Box _tasksBox, _landsBox, _issuesBox, _vehiclesBox;
  late Box _tasks, _lands, _issues, _vehicles;

  Future<void> init() async {
    await Hive.initFlutter();
    _tasksBox = await Hive.openBox(_tasksBoxName);
    _landsBox = await Hive.openBox(_landsBoxName);
    _issuesBox = await Hive.openBox(_issuesBoxName);
    _vehiclesBox = await Hive.openBox(_vehiclesBoxName);

    _tasks = await Hive.openBox(_tasksName);
    _lands = await Hive.openBox(_landsName);
    _issues = await Hive.openBox(_issuesName);
    _vehicles = await Hive.openBox(_vehiclesName);

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {

        debugPrint('--> Got Internet !!!');

        await _sendCachedData();
      }
    });
  }


  Future<void> _sendCachedData() async {

    final List<dynamic> cachedLands =
        List<dynamic>.from(_landsBox.values.toList());

    final List<dynamic> cachedTasks =
        List<dynamic>.from(_tasksBox.values.toList());

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

    if (cachedTasks.isNotEmpty) {
      for (var task in cachedTasks) {
        try {
          await _firestoreTaskDataSource.addTask(task.toEntity());
        } catch (e, s) {
          debugPrintStack(
            label: '$e',
            stackTrace: s,
          );
        }
      }
      // Once the data is sent successfully, you can clear the cache
      await _landsBox.clear();
      await _tasksBox.clear();
    }
  }

  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
    await _landsBox.close();
    await _tasksBox.close();
  }
}
