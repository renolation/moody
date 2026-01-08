// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityEntryModelAdapter extends TypeAdapter<ActivityEntryModel> {
  @override
  final typeId = 1;

  @override
  ActivityEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityEntryModel(
      id: (fields[0] as num).toInt(),
      type: fields[1] as String,
      duration: (fields[2] as num).toInt(),
      intensity: fields[3] == null ? 2 : (fields[3] as num).toInt(),
      timestamp: fields[4] as DateTime,
      userId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityEntryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.intensity)
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
      other is ActivityEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
