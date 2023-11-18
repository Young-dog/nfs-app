// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LandModelAdapter extends TypeAdapter<LandModel> {
  @override
  final int typeId = 1;

  @override
  LandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LandModel(
      landId: fields[0] as String,
      title: fields[1] as String,
      square: fields[2] as int,
      coordinates: fields[3] as Point<num>,
    );
  }

  @override
  void write(BinaryWriter writer, LandModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.landId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.square)
      ..writeByte(3)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
