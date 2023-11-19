import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../services/cache_service.dart';
import '../../../../shared/domain/entities/land.dart';
import '../../domain/repositories/land_repository.dart';
import '../data_sources/firestore_land_data_source.dart';
import '../data_sources/local_land_data_source.dart';

class LandRepositoryImpl extends LandRepository {
  final LocalLandDataSource localLandDataSource;
  final FirestoreLandDataSource firestoreLandDataSource;

  LandRepositoryImpl(
    this.localLandDataSource,
    this.firestoreLandDataSource,
  );

  @override
  Future<void> addLand(Land land) async {
    await localLandDataSource.addLand(land).then((value) => debugPrint('---> '));

    Connectivity().checkConnectivity().then((value) async {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        await firestoreLandDataSource.addLand(land);
      }
    });


  }

  @override
  Future<List<Land>> getLands() async {
    // var items = appConfig.environment == 'local'
    //     ? await mockLandDataSource.getLands()
    //     : await firestoreLandDataSource.getLands(type);
    return await firestoreLandDataSource.getLands();

    // if ((await localLandDataSource.getLands()).isEmpty) {
    //   var items = appConfig.environment == 'local'
    //       ? await mockLandDataSource.getLands()
    //       : await firestoreLandDataSource.getLands();
    //   for (final item in items) {
    //     localLandDataSource.addLand(item);
    //   }
    //   return items;
    // } else {
    //   debugPrint('Getting categories from Hive');
    //   return localLandDataSource.getLands();
    // }
  }
}
