import 'package:flutter/cupertino.dart';

import '../../../../shared/domain/entities/land.dart';
import '../../domain/repositories/land_repository.dart';
import '../data_sources/firestore_land_data_source.dart';
import '../data_sources/local_firestore_data_source.dart';

class LandRepositoryImpl extends LandRepository {
  final LocalLandDataSource localLandDataSource;
  final FirestoreLandDataSource firestoreLandDataSource;

  LandRepositoryImpl(
    this.localLandDataSource,
    this.firestoreLandDataSource,
  );

  @override
  Future<void> addLand(Land land) async {

    // TODO: отправить запрос на проверку интернета

    // TODO: кладем в local - await localLandDataSource.addLand(land);

    // TODO: Если есть инет: то отправляем в firestore - await firestoreLandDataSource.addLand(land);

    await localLandDataSource.addLand(land);


    await firestoreLandDataSource.addLand(land);



    // return appConfig.environment == 'local'
    //     ? await localLandDataSource.addLand(land)
    //     : await firestoreLandDataSource.addLand(land);
    return await firestoreLandDataSource.addLand(land);
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
