class ContentModel {
  final String id;
  final String platform; // 'instagram', 'linkedin', 'twitter', 'facebook'
  final String contentType; // 'post', 'caption', 'ad_copy', 'story'
  final String text;
  final String tone;
  final List<String>? hashtags;
  final DateTime createdAt;

  ContentModel({
    required this.id,
    required this.platform,
    required this.contentType,
    required this.text,
    required this.tone,
    this.hashtags,
    required this.createdAt,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] as String,
      platform: json['platform'] as String,
      contentType: json['content_type'] as String,
      text: json['text'] as String,
      tone: json['tone'] as String,
      hashtags: json['hashtags'] != null 
          ? List<String>.from(json['hashtags'] as List)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'content_type': contentType,
      'text': text,
      'tone': tone,
      'hashtags': hashtags,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ContentModel copyWith({
    String? id,
    String? platform,
    String? contentType,
    String? text,
    String? tone,
    List<String>? hashtags,
    DateTime? createdAt,
  }) {
    return ContentModel(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      contentType: contentType ?? this.contentType,
      text: text ?? this.text,
      tone: tone ?? this.tone,
      hashtags: hashtags ?? this.hashtags,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
