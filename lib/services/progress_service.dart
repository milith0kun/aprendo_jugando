import '../models/progress.dart';
import '../models/gamification.dart';
import 'mock_data_service.dart';

class ProgressService {
  // Get progress for a child and activity
  Future<Progress?> getProgress(String childId, String activityId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockDataService.mockProgress.firstWhere(
        (p) => p.childId == childId && p.activityId == activityId,
      );
    } catch (e) {
      return null;
    }
  }

  // Get all progress for a child
  Future<List<Progress>> getChildProgress(String childId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.mockProgress
        .where((p) => p.childId == childId)
        .toList();
  }

  // Save activity completion
  Future<Progress> saveActivityCompletion({
    required String childId,
    required String activityId,
    required int score,
    required int durationSeconds,
    required int hintsUsed,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Find existing progress or create new
    Progress? existingProgress;
    try {
      existingProgress = MockDataService.mockProgress.firstWhere(
        (p) => p.childId == childId && p.activityId == activityId,
      );
    } catch (e) {
      existingProgress = null;
    }

    // Calculate rewards
    final pointsEarned = score;
    final coinsEarned = (score / 2).round();
    final experienceEarned = score;

    // Create new attempt
    final newAttempt = Attempt(
      attemptNumber: (existingProgress?.attempts ?? 0) + 1,
      startTime: DateTime.now().subtract(Duration(seconds: durationSeconds)),
      endTime: DateTime.now(),
      durationSeconds: durationSeconds,
      score: score,
      pointsEarned: pointsEarned,
      coinsEarned: coinsEarned,
      experienceEarned: experienceEarned,
    );

    Progress updatedProgress;
    if (existingProgress != null) {
      // Update existing progress
      final newAttempts = List<Attempt>.from(existingProgress.attemptsList);
      newAttempts.add(newAttempt);

      updatedProgress = Progress(
        id: existingProgress.id,
        childId: childId,
        activityId: activityId,
        status: score >= 70 ? 'completed' : 'in_progress',
        attempts: existingProgress.attempts + 1,
        completed: score >= 70,
        highestScore: score > existingProgress.highestScore
            ? score
            : existingProgress.highestScore,
        totalTimeSeconds: existingProgress.totalTimeSeconds + durationSeconds,
        hintsUsed: existingProgress.hintsUsed + hintsUsed,
        attemptsList: newAttempts,
        lastAttemptDate: DateTime.now(),
      );

      // Remove old and add updated
      MockDataService.mockProgress.removeWhere(
        (p) => p.childId == childId && p.activityId == activityId,
      );
      MockDataService.mockProgress.add(updatedProgress);
    } else {
      // Create new progress
      updatedProgress = Progress(
        id: 'progress_${DateTime.now().millisecondsSinceEpoch}',
        childId: childId,
        activityId: activityId,
        status: score >= 70 ? 'completed' : 'in_progress',
        attempts: 1,
        completed: score >= 70,
        highestScore: score,
        totalTimeSeconds: durationSeconds,
        hintsUsed: hintsUsed,
        attemptsList: [newAttempt],
        lastAttemptDate: DateTime.now(),
      );

      MockDataService.mockProgress.add(updatedProgress);
    }

    // Update gamification
    await _updateGamification(childId, pointsEarned, coinsEarned, experienceEarned);

    return updatedProgress;
  }

  // Update gamification data
  Future<void> _updateGamification(
    String childId,
    int points,
    int coins,
    int experience,
  ) async {
    try {
      final gamification = MockDataService.mockGamification.firstWhere(
        (g) => g.childId == childId,
      );

      final newExperience = gamification.experiencePoints + experience;
      final newLevel = _calculateLevel(newExperience);
      final expForNextLevel = _calculateExpForNextLevel(newLevel);

      // Update streak
      final now = DateTime.now();
      final lastActivity = gamification.streak.lastActivityDate;
      int newStreak = gamification.streak.currentStreak;
      int longestStreak = gamification.streak.longestStreak;

      if (lastActivity != null) {
        final daysDifference = now.difference(lastActivity).inDays;
        if (daysDifference == 0) {
          // Same day, keep streak
        } else if (daysDifference == 1) {
          // Consecutive day, increase streak
          newStreak++;
          if (newStreak > longestStreak) {
            longestStreak = newStreak;
          }
        } else {
          // Streak broken
          newStreak = 1;
        }
      } else {
        newStreak = 1;
      }

      final updatedGamification = Gamification(
        id: gamification.id,
        childId: childId,
        totalPoints: gamification.totalPoints + points,
        currentCoins: gamification.currentCoins + coins,
        totalCoinsEarned: gamification.totalCoinsEarned + coins,
        experiencePoints: newExperience,
        currentLevel: newLevel,
        experienceForNextLevel: expForNextLevel,
        streak: StreakInfo(
          currentStreak: newStreak,
          longestStreak: longestStreak,
          lastActivityDate: now,
        ),
        unlockedAchievements: gamification.unlockedAchievements,
      );

      // Remove old and add updated
      MockDataService.mockGamification
          .removeWhere((g) => g.childId == childId);
      MockDataService.mockGamification.add(updatedGamification);
    } catch (e) {
      // Create new gamification data if not exists
      final newGamification = Gamification(
        id: 'gamif_${DateTime.now().millisecondsSinceEpoch}',
        childId: childId,
        totalPoints: points,
        currentCoins: coins,
        totalCoinsEarned: coins,
        experiencePoints: experience,
        currentLevel: 1,
        experienceForNextLevel: 100,
        streak: StreakInfo(
          currentStreak: 1,
          longestStreak: 1,
          lastActivityDate: DateTime.now(),
        ),
        unlockedAchievements: [],
      );

      MockDataService.mockGamification.add(newGamification);
    }
  }

  int _calculateLevel(int experience) {
    // Simple formula: Level = floor(experience / 100) + 1
    return (experience / 100).floor() + 1;
  }

  int _calculateExpForNextLevel(int level) {
    return level * 100;
  }

  // Get gamification data
  Future<Gamification?> getGamification(String childId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockDataService.mockGamification.firstWhere(
        (g) => g.childId == childId,
      );
    } catch (e) {
      // Create default if not exists
      final newGamification = Gamification(
        id: 'gamif_${DateTime.now().millisecondsSinceEpoch}',
        childId: childId,
        streak: StreakInfo(),
      );
      MockDataService.mockGamification.add(newGamification);
      return newGamification;
    }
  }
}
