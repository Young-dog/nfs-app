// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_report_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LandReportModelAdapter extends TypeAdapter<LandReportModel> {
  @override
  final int typeId = 5;

  @override
  LandReportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LandReportModel(
      landId: fields[0] as String,
      reportId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LandReportModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.landId)
      ..writeByte(1)
      ..write(obj.reportId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandReportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
