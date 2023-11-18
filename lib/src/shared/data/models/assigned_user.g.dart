// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignedUserAdapter extends TypeAdapter<AssignedUser> {
  @override
  final int typeId = 7;

  @override
  AssignedUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssignedUser(
      userId: fields[0] as String,
      fullName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AssignedUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignedUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
