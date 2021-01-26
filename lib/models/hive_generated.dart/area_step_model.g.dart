// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../area/area_step_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaStepAdapter extends TypeAdapter<AreaStep> {
  @override
  final int typeId = 11;

  @override
  AreaStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AreaStep(
      id: fields[0] as String,
      areaId: fields[3] as String,
      stepinfo: fields[2] as String,
      step: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AreaStep obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.stepinfo)
      ..writeByte(3)
      ..write(obj.areaId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
