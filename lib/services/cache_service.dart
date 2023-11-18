import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  final String _boxName = 'cachedData';
  late Box _box;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {

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

    final List<String> cachedData = List<String>.from(_box.values);

    debugPrint('--- cachedData= ${cachedData.length}');


    if (cachedData.isNotEmpty) {
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