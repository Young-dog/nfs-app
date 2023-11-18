// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueModelAdapter extends TypeAdapter<IssueModel> {
  @override
  final int typeId = 11;

  @override
  IssueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssueModel(
      issueId: fields[0] as String,
      state: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      createdBy: fields[4] as AssignedUser,
      assignedTo: fields[5] as AssignedUser?,
      closedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, IssueModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.issueId)
      ..writeByte(1)
      ..write(obj.state)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.assignedTo)
      ..writeByte(6)
      ..write(obj.closedAt)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
