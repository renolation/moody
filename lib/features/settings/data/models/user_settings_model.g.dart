// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsModelAdapter extends TypeAdapter<UserSettingsModel> {
  @override
  final typeId = 5;

  @override
  UserSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsModel(
      userName: fields[0] == null ? 'Alex' : fields[0] as String,
      userEmail: fields[1] as String?,
      isVip: fields[2] == null ? false : fields[2] as bool,
      healthSyncEnabled: fields[3] == null ? false : fields[3] as bool,
      dailyQuoteHour: fields[4] == null ? 8 : (fields[4] as num).toInt(),
      dailyQuoteMinute: fields[5] == null ? 0 : (fields[5] as num).toInt(),
      moodReminderHour: fields[6] == null ? 21 : (fields[6] as num).toInt(),
      moodReminderMinute: fields[7] == null ? 0 : (fields[7] as num).toInt(),
      theme: fields[8] == null ? 'dark' : fields[8] as String,
      walkingDuration: fields[9] == null ? 30 : (fields[9] as num).toInt(),
      runningDuration: fields[10] == null ? 30 : (fields[10] as num).toInt(),
      yogaDuration: fields[11] == null ? 30 : (fields[11] as num).toInt(),
      gymDuration: fields[12] == null ? 45 : (fields[12] as num).toInt(),
      cyclingDuration: fields[13] == null ? 30 : (fields[13] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingsModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.userEmail)
      ..writeByte(2)
      ..write(obj.isVip)
      ..writeByte(3)
      ..write(obj.healthSyncEnabled)
      ..writeByte(4)
      ..write(obj.dailyQuoteHour)
      ..writeByte(5)
      ..write(obj.dailyQuoteMinute)
      ..writeByte(6)
      ..write(obj.moodReminderHour)
      ..writeByte(7)
      ..write(obj.moodReminderMinute)
      ..writeByte(8)
      ..write(obj.theme)
      ..writeByte(9)
      ..write(obj.walkingDuration)
      ..writeByte(10)
      ..write(obj.runningDuration)
      ..writeByte(11)
      ..write(obj.yogaDuration)
      ..writeByte(12)
      ..write(obj.gymDuration)
      ..writeByte(13)
      ..write(obj.cyclingDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
