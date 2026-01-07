class Sound {
  final String id;
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
}
