import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';

import '../../../../shared/data/models/land_model.dart';
import '../../../../shared/domain/entities/land.dart';

abstract class LocalLandDataSource {
  Future<List<Land>> getLands();

  Future<void> addLand(Land land);
}

class LocalLandDataSourceImpl extends LocalLandDataSource {
  Future<Box> _openBox() async {
    return Hive.openBox<LandModel>('lands');
  }

  @override
  Future<void> addLand(Land land) async {
    Box box = await _openBox();
    final id = DateTime.now();
    await Connectivity().checkConnectivity().then((value) async {
      if (value != ConnectivityResult.mobile &&
          value != ConnectivityResult.wifi) {
        await Hive.box('cachedData')
            .put('land.landId', LandModel.fromEntity(land));
      }
    });
    print(Hive.box('cachedData').length);
  }

  @override
  Future<List<Land>> getLands() async {
    Box<LandModel> box = await _openBox() as Box<LandModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }
}
