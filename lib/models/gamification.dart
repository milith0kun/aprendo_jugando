class Gamification {
  final String id;
  final String childId;
  final int totalPoints;
  final int currentCoins;
  final int totalCoinsEarned;
  final int experiencePoints;
  final int currentLevel;
  final int experienceForNextLevel;
  final StreakInfo streak;
  final List<Achievement> unlockedAchievements;

  Gamification({
    required this.id,
    required this.childId,
    this.totalPoints = 0,
    this.currentCoins = 0,
    this.totalCoinsEarned = 0,
    this.experiencePoints = 0,
    this.currentLevel = 1,
    this.experienceForNextLevel = 100,
    required this.streak,
    this.unlockedAchievements = const [],
  });

  double get progressToNextLevel {
    if (experienceForNextLevel == 0) return 0;
    final expInCurrentLevel = experiencePoints - _experienceForLevel(currentLevel);
    final expNeededForLevel = experienceForNextLevel;
    return (expInCurrentLevel / expNeededForLevel).clamp(0.0, 1.0);
  }

  int _experienceForLevel(int level) {
    // Simple formula: 100 * level for cumulative experience
    int total = 0;
    for (int i = 1; i < level; i++) {
      total += 100 * i;
    }
    return total;
  }

  factory Gamification.fromJson(Map<String, dynamic> json) {
    return Gamification(
      id: json['id'] as String,
      childId: json['childId'] as String,
      totalPoints: json['totalPoints'] as int? ?? 0,
      currentCoins: json['currentCoins'] as int? ?? 0,
      totalCoinsEarned: json['totalCoinsEarned'] as int? ?? 0,
      experiencePoints: json['experiencePoints'] as int? ?? 0,
      currentLevel: json['currentLevel'] as int? ?? 1,
      experienceForNextLevel: json['experienceForNextLevel'] as int? ?? 100,
      streak: StreakInfo.fromJson(json['streak'] as Map<String, dynamic>),
      unlockedAchievements: (json['unlockedAchievements'] as List<dynamic>?)
              ?.map((a) => Achievement.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childId': childId,
      'totalPoints': totalPoints,
      'currentCoins': currentCoins,
      'totalCoinsEarned': totalCoinsEarned,
      'experiencePoints': experiencePoints,
      'currentLevel': currentLevel,
      'experienceForNextLevel': experienceForNextLevel,
      'streak': streak.toJson(),
      'unlockedAchievements': unlockedAchievements.map((a) => a.toJson()).toList(),
    };
  }
}

class StreakInfo {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;

  StreakInfo({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActivityDate,
  });

  factory StreakInfo.fromJson(Map<String, dynamic> json) {
    return StreakInfo(
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastActivityDate: json['lastActivityDate'] != null
          ? DateTime.parse(json['lastActivityDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivityDate': lastActivityDate?.toIso8601String(),
    };
  }
}

class Achievement {
  final String id;
  final String code;
  final String name;
  final String description;
  final String iconUrl;
  final String category; // 'bronze', 'silver', 'gold', 'platinum'
  final int rewardPoints;
  final DateTime unlockedDate;

  Achievement({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.category,
    required this.rewardPoints,
    required this.unlockedDate,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      category: json['category'] as String,
      rewardPoints: json['rewardPoints'] as int,
      unlockedDate: DateTime.parse(json['unlockedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'category': category,
      'rewardPoints': rewardPoints,
      'unlockedDate': unlockedDate.toIso8601String(),
    };
  }
}
