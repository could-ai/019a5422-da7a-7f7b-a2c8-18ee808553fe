class LogoModel {
  final String id;
  final String imageUrl;
  final String prompt;
  final String? style;
  final List<String> colors;
  final DateTime createdAt;

  LogoModel({
    required this.id,
    required this.imageUrl,
    required this.prompt,
    this.style,
    required this.colors,
    required this.createdAt,
  });

  factory LogoModel.fromJson(Map<String, dynamic> json) {
    return LogoModel(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String,
      prompt: json['prompt'] as String,
      style: json['style'] as String?,
      colors: List<String>.from(json['colors'] as List? ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'prompt': prompt,
      'style': style,
      'colors': colors,
      'created_at': createdAt.toIso8601String(),
    };
  }

  LogoModel copyWith({
    String? id,
    String? imageUrl,
    String? prompt,
    String? style,
    List<String>? colors,
    DateTime? createdAt,
  }) {
    return LogoModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      prompt: prompt ?? this.prompt,
      style: style ?? this.style,
      colors: colors ?? this.colors,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
