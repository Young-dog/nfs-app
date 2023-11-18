import 'package:equatable/equatable.dart';

class LandSoilCondition extends Equatable {
  final String landId;
  final String conditionId;
  final String type;

  const LandSoilCondition({
    required this.landId,
    required this.conditionId,
    required this.type,
  });

  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'conditionId': conditionId,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
        landId,
        conditionId,
        type,
      ];
}
