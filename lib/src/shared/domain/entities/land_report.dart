import 'package:equatable/equatable.dart';

class LandReport extends Equatable {
  final String landId;
  final String reportId;

  const LandReport({
    required this.landId,
    required this.reportId,
  });


  Map<String, dynamic> toDocument() {
    return {
      'landId': landId,
      'reportId': reportId,
    };
  }

  @override
  List<Object?> get props => [
    landId,
        reportId,
      ];
}
