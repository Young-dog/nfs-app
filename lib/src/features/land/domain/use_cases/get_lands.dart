import 'package:app/src/shared/domain/entities/land.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';

import '../repositories/land_repository.dart';

class GetLands extends UseCase<List<Land>, NoParams> {
  final LandRepository landRepository;

  GetLands(this.landRepository);
  @override
  Future<List<Land>> call(NoParams params) {
    return landRepository.getLands();
  }

}