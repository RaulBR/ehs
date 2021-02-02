// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../area/area_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaAdapter extends TypeAdapter<Area> {
  @override
  final int typeId = 3;

  @override
  Area read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Area(
      id: fields[0] as String,
      area: fields[1] as String,
      areaInfo: fields[2] as String,
      steps: (fields[3] as List)?.cast<AreaStep>(),
      roles: (fields[4] as List)?.cast<AreaRole>(),
    );
  }

  @override
  void write(BinaryWriter writer, Area obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.area)
      ..writeByte(2)
      ..write(obj.areaInfo)
      ..writeByte(3)
      ..write(obj.steps)
      ..writeByte(4)
      ..write(obj.roles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
