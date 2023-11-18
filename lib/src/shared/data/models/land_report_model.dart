import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/land_report.dart';

part 'land_report_model.g.dart';

@HiveType(typeId: 5)
class LandReportModel {
  @HiveField(0)
  final String landId;
  @HiveField(1)
  final String reportId;

  LandReportModel({
    required this.landId,
    required this.reportId,
  });

  factory LandReportModel.fromJson(Map<String, dynamic> json) {
    return LandReportModel(
      landId: json['landId'],
      reportId: json['reportId'],
    );
  }

  factory LandReportModel.fromSnapshot(DocumentSnapshot snap) {
    return LandReportModel(
      landId: snap['landId'],
      reportId: snap['reportId'],
    );
  }

  factory LandReportModel.fromEntity(LandReport report) {
    return LandReportModel(
      landId: report.landId,
      reportId: report.reportId,
    );
  }

  LandReport toEntity() {
    return LandReport(
      landId: landId,
      reportId: reportId,
    );
  }
}
