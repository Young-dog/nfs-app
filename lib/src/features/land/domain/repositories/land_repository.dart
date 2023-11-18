import 'package:app/src/shared/domain/entities/land.dart';

abstract class LandRepository {
  Future<List<Land>> getLands();
  Future<void> addLand(Land land);
  // TODO: getLandsByQuery (поиск)
}