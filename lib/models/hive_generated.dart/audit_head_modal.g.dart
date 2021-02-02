// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action/audit_head_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditHeadAdapter extends TypeAdapter<AuditHead> {
  @override
  final int typeId = 4;

  @override
  AuditHead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuditHead(
      id: fields[0] as String,
      area: fields[1] as String,
      step: fields[2] as String,
      sector: fields[3] as String,
      auditStatus: fields[5] as String,
    )
      ..auditType = fields[4] as String
      ..employee = fields[6] as Employee
      ..createdDate = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, AuditHead obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.area)
      ..writeByte(2)
      ..write(obj.step)
      ..writeByte(3)
      ..write(obj.sector)
      ..writeByte(4)
      ..write(obj.auditType)
      ..writeByte(5)
      ..write(obj.auditStatus)
      ..writeByte(6)
      ..write(obj.employee)
      ..writeByte(7)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditHeadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
