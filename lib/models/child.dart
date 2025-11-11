class Child {
  final String id;
  final String parentId;
  final String username;
  final String displayName;
  final DateTime dateOfBirth;
  final int grade; // 1-6 for primary school
  final String pin; // 4 digit PIN (hashed in real app)
  final AvatarConfig avatar;
  final ChildPreferences preferences;
  final DateTime? lastActivity;
  final int totalMinutes;

  Child({
    required this.id,
    required this.parentId,
    required this.username,
    required this.displayName,
    required this.dateOfBirth,
    required this.grade,
    required this.pin,
    required this.avatar,
    required this.preferences,
    this.lastActivity,
    this.totalMinutes = 0,
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      grade: json['grade'] as int,
      pin: json['pin'] as String,
      avatar: AvatarConfig.fromJson(json['avatar'] as Map<String, dynamic>),
      preferences: ChildPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
      lastActivity: json['lastActivity'] != null
          ? DateTime.parse(json['lastActivity'] as String)
          : null,
      totalMinutes: json['totalMinutes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'username': username,
      'displayName': displayName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'grade': grade,
      'pin': pin,
      'avatar': avatar.toJson(),
      'preferences': preferences.toJson(),
      'lastActivity': lastActivity?.toIso8601String(),
      'totalMinutes': totalMinutes,
    };
  }
}

class AvatarConfig {
  final String baseType;
  final List<String> accessories;
  final String skinColor;
  final String hairColor;
  final String eyeColor;

  AvatarConfig({
    required this.baseType,
    this.accessories = const [],
    this.skinColor = '#FFD1A7',
    this.hairColor = '#4A2C0A',
    this.eyeColor = '#2C1F14',
  });

  factory AvatarConfig.fromJson(Map<String, dynamic> json) {
    return AvatarConfig(
      baseType: json['baseType'] as String,
      accessories: (json['accessories'] as List<dynamic>?)?.cast<String>() ?? [],
      skinColor: json['skinColor'] as String? ?? '#FFD1A7',
      hairColor: json['hairColor'] as String? ?? '#4A2C0A',
      eyeColor: json['eyeColor'] as String? ?? '#2C1F14',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseType': baseType,
      'accessories': accessories,
      'skinColor': skinColor,
      'hairColor': hairColor,
      'eyeColor': eyeColor,
    };
  }
}

class ChildPreferences {
  final String theme;
  final bool soundEnabled;
  final bool musicEnabled;
  final int difficultyLevel; // 1-5

  ChildPreferences({
    this.theme = 'light',
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.difficultyLevel = 3,
  });

  factory ChildPreferences.fromJson(Map<String, dynamic> json) {
    return ChildPreferences(
      theme: json['theme'] as String? ?? 'light',
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      difficultyLevel: json['difficultyLevel'] as int? ?? 3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'soundEnabled': soundEnabled,
      'musicEnabled': musicEnabled,
      'difficultyLevel': difficultyLevel,
    };
  }
}
