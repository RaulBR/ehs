// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action/audit_action_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditActionAdapter extends TypeAdapter<AuditAction> {
  @override
  final int typeId = 9;

  @override
  AuditAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuditAction(
      imidiatAcction: fields[1] as bool,
      comment: fields[4] as String,
      limitDate: fields[3] as String,
      responsible: fields[2] as Employee,
    )
      ..id = fields[0] as String
      ..type = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, AuditAction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imidiatAcction)
      ..writeByte(2)
      ..write(obj.responsible)
      ..writeByte(3)
      ..write(obj.limitDate)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
