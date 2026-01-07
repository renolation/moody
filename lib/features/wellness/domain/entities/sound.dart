import 'package:equatable/equatable.dart';

class Sound extends Equatable {
  final int id;
  final String name;
  final String icon;
  final String assetPath;
  final bool isPremium;

  const Sound({
    required this.id,
    required this.name,
    required this.icon,
    required this.assetPath,
    this.isPremium = false,
  });

  @override
  List<Object?> get props => [id, name, icon, assetPath, isPremium];
}
