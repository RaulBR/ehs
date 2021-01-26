// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../aspect/aspect_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AspectPhotoAdapter extends TypeAdapter<AspectPhoto> {
  @override
  final int typeId = 12;

  @override
  AspectPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AspectPhoto(
      id: fields[0] as String,
      name: fields[1] as String,
      photo: fields[6] as String,
      size: fields[3] as String,
      type: fields[2] as String,
    )
      ..aspectId = fields[4] as String
      ..createdDate = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, AspectPhoto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.aspectId)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AspectPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
