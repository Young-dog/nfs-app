// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_recommendation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LandRecommendationModelAdapter
    extends TypeAdapter<LandRecommendationModel> {
  @override
  final int typeId = 4;

  @override
  LandRecommendationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LandRecommendationModel(
      landId: fields[0] as String,
      recommendationId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LandRecommendationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.landId)
      ..writeByte(1)
      ..write(obj.recommendationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandRecommendationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
