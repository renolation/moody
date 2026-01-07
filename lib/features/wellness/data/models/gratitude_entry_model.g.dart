// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gratitude_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GratitudeEntryModelAdapter extends TypeAdapter<GratitudeEntryModel> {
  @override
  final typeId = 3;

  @override
  GratitudeEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GratitudeEntryModel(
      id: (fields[0] as num).toInt(),
      items: (fields[1] as List).cast<String>(),
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GratitudeEntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.items)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GratitudeEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
