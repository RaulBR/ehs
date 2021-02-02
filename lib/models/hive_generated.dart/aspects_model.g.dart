// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../aspect/aspects_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AspectAdapter extends TypeAdapter<Aspect> {
  @override
  final int typeId = 13;

  @override
  Aspect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Aspect(
      id: fields[0] as String,
      category: fields[1] as String,
      comment: fields[2] as String,
      auditId: fields[6] as String,
      type: fields[7] as String,
      status: fields[8] as String,
      action: fields[12] as AuditAction,
      audit: fields[11] as AuditHead,
      photos: (fields[13] as List)?.cast<AspectPhoto>(),
    )
      ..rejectComment = fields[3] as String
      ..categoryType = fields[4] as String
      ..equipment = fields[5] as String
      ..auditActionId = fields[9] as String
      ..createdDate = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, Aspect obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.rejectComment)
      ..writeByte(4)
      ..write(obj.categoryType)
      ..writeByte(5)
      ..write(obj.equipment)
      ..writeByte(6)
      ..write(obj.auditId)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.auditActionId)
      ..writeByte(10)
      ..write(obj.createdDate)
      ..writeByte(11)
      ..write(obj.audit)
      ..writeByte(12)
      ..write(obj.action)
      ..writeByte(13)
      ..write(obj.photos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AspectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
