import 'package:app/src/features/land/domain/repositories/land_repository.dart';
import 'package:app/src/shared/domain/entities/land.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';

class AddLand implements UseCase<void, AddLandParams> {
  final LandRepository landRepository;

  AddLand(this.landRepository);

  @override
  Future<void> call(AddLandParams params) {
    return landRepository.addLand(params.land);
  }

}

class AddLandParams extends Equatable {
  final Land land;

  const AddLandParams({required this.land});
  @override
  List<Object?> get props => [land];
}