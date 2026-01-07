import '../../domain/entities/sound.dart';

class SoundModel {
  final String id;
  final String name;
  final String icon;
  final String assetPath;
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
      id: json['id'] as String,
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
}
