import 'package:equatable/equatable.dart';

class LandPlantCondition extends Equatable {
  final String landId;
  final String conditionId;

  const LandPlantCondition({
    required this.landId,
    required this.conditionId,
  });

  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'conditionId': conditionId,
    };
  }

  @override
  List<Object?> get props => [
        landId,
        conditionId,
      ];
}
