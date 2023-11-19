import 'dart:async';

import 'package:connectivity/connectivity.dart';
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
    final result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      await firestoreLandDataSource.addLand(land);
    } else {
      await localLandDataSource.addLand(land);
    }
  }

  @override
  Future<List<Land>> getLands() async {
    final result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      var items = await firestoreLandDataSource.getLands();
      for (final item in items) {
        localLandDataSource.addLand(item);
      }
      return items;
    } else {
      var items = await firestoreLandDataSource.getLands();
      return items;
    }
  }
}
