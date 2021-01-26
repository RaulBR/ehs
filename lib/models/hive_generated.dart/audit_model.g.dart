// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action/audit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditAdapter extends TypeAdapter<Audit> {
  @override
  final int typeId = 8;

  @override
  Audit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audit(
      auditHead: fields[0] as AuditHead,
      positiveAspects: (fields[1] as List)?.cast<Aspect>(),
      negativeAspects: (fields[2] as List)?.cast<Aspect>(),
    );
  }

  @override
  void write(BinaryWriter writer, Audit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.auditHead)
      ..writeByte(1)
      ..write(obj.positiveAspects)
      ..writeByte(2)
      ..write(obj.negativeAspects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
