class BrandModel {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final String industry;
  final String tone;
  final String targetAudience;
  final List<String> colorPalette;
  final List<String> fonts;
  final String? logoUrl;
  final DateTime createdAt;

  BrandModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.industry,
    required this.tone,
    required this.targetAudience,
    required this.colorPalette,
    required this.fonts,
    this.logoUrl,
    required this.createdAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      industry: json['industry'] as String,
      tone: json['tone'] as String,
      targetAudience: json['target_audience'] as String,
      colorPalette: List<String>.from(json['color_palette'] as List),
      fonts: List<String>.from(json['fonts'] as List),
      logoUrl: json['logo_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'industry': industry,
      'tone': tone,
      'target_audience': targetAudience,
      'color_palette': colorPalette,
      'fonts': fonts,
      'logo_url': logoUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  BrandModel copyWith({
    String? id,
    String? name,
    String? tagline,
    String? description,
    String? industry,
    String? tone,
    String? targetAudience,
    List<String>? colorPalette,
    List<String>? fonts,
    String? logoUrl,
    DateTime? createdAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      industry: industry ?? this.industry,
      tone: tone ?? this.tone,
      targetAudience: targetAudience ?? this.targetAudience,
      colorPalette: colorPalette ?? this.colorPalette,
      fonts: fonts ?? this.fonts,
      logoUrl: logoUrl ?? this.logoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
