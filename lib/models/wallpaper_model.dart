class Wallpaper {
  final String imageUrl;
  final String description;

  Wallpaper({
    required this.imageUrl,
    required this.description,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      imageUrl: json['urls']['full'],
      description: json['alt_description'] ?? json['description'] ?? 'No description available',
    );
  }
}