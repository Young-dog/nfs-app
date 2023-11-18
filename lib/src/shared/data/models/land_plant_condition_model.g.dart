// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_plant_condition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LandPlantConditionModelAdapter
    extends TypeAdapter<LandPlantConditionModel> {
  @override
  final int typeId = 2;

  @override
  LandPlantConditionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LandPlantConditionModel(
      landId: fields[1] as String,
      conditionId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LandPlantConditionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.conditionId)
      ..writeByte(1)
      ..write(obj.landId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandPlantConditionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
