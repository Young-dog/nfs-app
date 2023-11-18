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
    await box.put(land.landId, LandModel.fromEntity(land));
  }

  @override
  Future<List<Land>> getLands() async {
    Box<LandModel> box = await _openBox() as Box<LandModel>;
    return box.values.toList().map((item) => item.toEntity()).toList();
  }

}
