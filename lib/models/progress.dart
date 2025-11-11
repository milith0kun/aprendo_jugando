class Progress {
  final String id;
  final String childId;
  final String activityId;
  final String status; // 'not_started', 'in_progress', 'completed', 'mastered'
  final int attempts;
  final bool completed;
  final int highestScore;
  final int totalTimeSeconds;
  final int hintsUsed;
  final List<Attempt> attemptsList;
  final DateTime? lastAttemptDate;

  Progress({
    required this.id,
    required this.childId,
    required this.activityId,
    required this.status,
    this.attempts = 0,
    this.completed = false,
    this.highestScore = 0,
    this.totalTimeSeconds = 0,
    this.hintsUsed = 0,
    this.attemptsList = const [],
    this.lastAttemptDate,
  });

  double get averageScore {
    if (attemptsList.isEmpty) return 0;
    final totalScore = attemptsList.fold<int>(0, (sum, attempt) => sum + attempt.score);
    return totalScore / attemptsList.length;
  }

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] as String,
      childId: json['childId'] as String,
      activityId: json['activityId'] as String,
      status: json['status'] as String,
      attempts: json['attempts'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      highestScore: json['highestScore'] as int? ?? 0,
      totalTimeSeconds: json['totalTimeSeconds'] as int? ?? 0,
      hintsUsed: json['hintsUsed'] as int? ?? 0,
      attemptsList: (json['attemptsList'] as List<dynamic>?)
              ?.map((a) => Attempt.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      lastAttemptDate: json['lastAttemptDate'] != null
          ? DateTime.parse(json['lastAttemptDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childId': childId,
      'activityId': activityId,
      'status': status,
      'attempts': attempts,
      'completed': completed,
      'highestScore': highestScore,
      'totalTimeSeconds': totalTimeSeconds,
      'hintsUsed': hintsUsed,
      'attemptsList': attemptsList.map((a) => a.toJson()).toList(),
      'lastAttemptDate': lastAttemptDate?.toIso8601String(),
    };
  }
}

class Attempt {
  final int attemptNumber;
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final int score;
  final int pointsEarned;
  final int coinsEarned;
  final int experienceEarned;

  Attempt({
    required this.attemptNumber,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.score,
    required this.pointsEarned,
    required this.coinsEarned,
    required this.experienceEarned,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) {
    return Attempt(
      attemptNumber: json['attemptNumber'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      durationSeconds: json['durationSeconds'] as int,
      score: json['score'] as int,
      pointsEarned: json['pointsEarned'] as int,
      coinsEarned: json['coinsEarned'] as int,
      experienceEarned: json['experienceEarned'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attemptNumber': attemptNumber,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'durationSeconds': durationSeconds,
      'score': score,
      'pointsEarned': pointsEarned,
      'coinsEarned': coinsEarned,
      'experienceEarned': experienceEarned,
    };
  }
}
