// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../area/area_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaRoleAdapter extends TypeAdapter<AreaRole> {
  @override
  final int typeId = 10;

  @override
  AreaRole read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AreaRole(
      id: fields[1] as String,
      role: fields[0] as String,
      responsible: fields[2] as Employee,
    );
  }

  @override
  void write(BinaryWriter writer, AreaRole obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.responsible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
