// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntryModelAdapter extends TypeAdapter<MoodEntryModel> {
  @override
  final typeId = 0;

  @override
  MoodEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntryModel(
      id: (fields[0] as num).toInt(),
      score: (fields[1] as num).toInt(),
      note: fields[2] as String?,
      tags: fields[3] == null ? const [] : (fields[3] as List).cast<String>(),
      timestamp: fields[4] as DateTime,
      userId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
