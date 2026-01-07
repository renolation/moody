// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SoundModelAdapter extends TypeAdapter<SoundModel> {
  @override
  final typeId = 4;

  @override
  SoundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SoundModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      icon: fields[2] as String,
      assetPath: fields[3] as String,
      isPremium: fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SoundModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.assetPath)
      ..writeByte(4)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
