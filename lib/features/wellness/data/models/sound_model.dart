import 'package:hive_ce/hive.dart';

import '../../domain/entities/sound.dart';

part 'sound_model.g.dart';

@HiveType(typeId: 4)
class SoundModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  @HiveField(3)
  final String assetPath;

  @HiveField(4)
  final bool isPremium;

  SoundModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.assetPath,
    this.isPremium = false,
  });

  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      assetPath: json['assetPath'] as String,
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'assetPath': assetPath,
      'isPremium': isPremium,
    };
  }

  Sound toEntity() {
    return Sound(
      id: id,
      name: name,
      icon: icon,
      assetPath: assetPath,
      isPremium: isPremium,
    );
  }

  factory SoundModel.fromEntity(Sound entity) {
    return SoundModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      assetPath: entity.assetPath,
      isPremium: entity.isPremium,
    );
  }
}
