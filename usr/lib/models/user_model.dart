class UserModel {
  final String id;
  final String email;
  final String name;
  final String subscriptionPlan; // 'free', 'pro', 'business'
  final DateTime createdAt;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.subscriptionPlan,
    required this.createdAt,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      subscriptionPlan: json['subscription_plan'] as String? ?? 'free',
      createdAt: DateTime.parse(json['created_at'] as String),
      photoUrl: json['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'subscription_plan': subscriptionPlan,
      'created_at': createdAt.toIso8601String(),
      'photo_url': photoUrl,
    };
  }

  bool get isFree => subscriptionPlan == 'free';
  bool get isPro => subscriptionPlan == 'pro';
  bool get isBusiness => subscriptionPlan == 'business';

  // Plan limits
  int get maxBrands {
    switch (subscriptionPlan) {
      case 'free':
        return 3;
      case 'pro':
        return 25;
      case 'business':
        return -1; // unlimited
      default:
        return 3;
    }
  }

  int get maxLogoGenerations {
    switch (subscriptionPlan) {
      case 'free':
        return 5;
      case 'pro':
        return 50;
      case 'business':
        return -1; // unlimited
      default:
        return 5;
    }
  }
}
