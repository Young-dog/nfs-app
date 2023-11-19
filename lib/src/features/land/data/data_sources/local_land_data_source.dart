import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';

import '../../../../shared/data/models/land_model.dart';
import '../../../../shared/domain/entities/land.dart';

abstract class LocalLandDataSource {
  Future<List<Land>> getLands();

  Future<void> addLand(Land land);
}

class LocalLandDataSourceImpl extends LocalLandDataSource {
  final _box = Hive.box('lands');

  Future<Box> _getBox() async {
    return _box;
  }

  @override
  Future<void> addLand(Land land) async {
    await Connectivity().checkConnectivity().then((value) async {
      if (value != ConnectivityResult.mobile &&
          value != ConnectivityResult.wifi) {
        await _box.put(land.landId, LandModel.fromEntity(land));
      }
    });
  }

  @override
  Future<List<Land>> getLands() async {
    Box<LandModel> box = await _getBox() as Box<LandModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }
}
