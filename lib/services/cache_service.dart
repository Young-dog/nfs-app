import 'dart:async';

import 'package:app/src/shared/data/models/land_model.dart';
import 'package:app/src/shared/domain/entities/land.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../src/features/land/data/data_sources/firestore_land_data_source.dart';

class CacheService {
  CacheService({
    required FirestoreLandDataSource firestoreLandDataSource,
  }) : _firestoreLandDataSource = firestoreLandDataSource;
  final String _boxName = 'cachedData';
  late Box _box;
  final FirestoreLandDataSource _firestoreLandDataSource;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print('------------------> Yeas!!! Got internet!!!');

        await _sendCachedData();
      }
    });
  }

  Future<void> saveData(String data) async {
    await _box.add(data);
  }

  Future<List<String>> getCachedData() async {
    return List<String>.from(_box.values);
  }

  Future<void> _sendCachedData() async {
    debugPrint('--- ');

    final List<dynamic> cachedData = List<dynamic>.from(_box.values.toList());

    debugPrint('--- cachedData= ${cachedData.toList().length}');

    if (cachedData.isNotEmpty) {
      for (final data in cachedData) {
        print(data.runtimeType);
        if (data.runtimeType == LandModel) {
          data as LandModel;
          print('-------> start');
          await _firestoreLandDataSource.addLand(
            data.toEntity(),
          );
        }
      }
      // Implement your data sending logic here
      // For example, you can make a network request to send the data
      print('------------------> Sending cached data: $cachedData');

      // Once the data is sent successfully, you can clear the cache
      await _box.clear();
    }
  }

  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
    await _box.close();
  }
}
