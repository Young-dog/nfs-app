// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_soil_condition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LandSoilConditionModelAdapter
    extends TypeAdapter<LandSoilConditionModel> {
  @override
  final int typeId = 3;

  @override
  LandSoilConditionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LandSoilConditionModel(
      landId: fields[1] as String,
      conditionId: fields[0] as String,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LandSoilConditionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.conditionId)
      ..writeByte(1)
      ..write(obj.landId)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandSoilConditionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
