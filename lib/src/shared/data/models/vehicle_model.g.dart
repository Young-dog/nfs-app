// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleModelAdapter extends TypeAdapter<VehicleModel> {
  @override
  final int typeId = 10;

  @override
  VehicleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleModel(
      vehicleId: fields[1] as String,
      createdBy: fields[2] as UserInfoModel,
      assignedTo: fields[3] as UserInfoModel?,
      name: fields[0] as String,
      operation: fields[6] as String,
      workingSpeed: fields[8] as String,
      unit: fields[9] as UnitModel?,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.vehicleId)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.assignedTo)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.operation)
      ..writeByte(8)
      ..write(obj.workingSpeed)
      ..writeByte(9)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
