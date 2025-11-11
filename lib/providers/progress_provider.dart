import 'package:flutter/material.dart';
import '../models/progress.dart';
import '../models/gamification.dart';
import '../services/progress_service.dart';

class ProgressProvider extends ChangeNotifier {
  final ProgressService _progressService = ProgressService();

  Map<String, Progress> _progressMap = {};
  Gamification? _gamification;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Gamification? get gamification => _gamification;

  // Load all progress for a child
  Future<void> loadChildProgress(String childId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final progressList = await _progressService.getChildProgress(childId);
      _progressMap = {for (var p in progressList) '${p.childId}_${p.activityId}': p};

      // Also load gamification
      _gamification = await _progressService.getGamification(childId);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get progress for specific activity
  Progress? getProgressForActivity(String childId, String activityId) {
    return _progressMap['${childId}_$activityId'];
  }

  // Save activity completion
  Future<bool> completeActivity({
    required String childId,
    required String activityId,
    required int score,
    required int durationSeconds,
    required int hintsUsed,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final progress = await _progressService.saveActivityCompletion(
        childId: childId,
        activityId: activityId,
        score: score,
        durationSeconds: durationSeconds,
        hintsUsed: hintsUsed,
      );

      _progressMap['${childId}_$activityId'] = progress;

      // Reload gamification to get updated data
      _gamification = await _progressService.getGamification(childId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get completion statistics
  Map<String, int> getCompletionStats(String childId) {
    final childProgress = _progressMap.values
        .where((p) => p.childId == childId)
        .toList();

    return {
      'total': childProgress.length,
      'completed': childProgress.where((p) => p.completed).length,
      'inProgress': childProgress.where((p) => p.status == 'in_progress').length,
    };
  }

  // Get average score
  double getAverageScore(String childId) {
    final childProgress = _progressMap.values
        .where((p) => p.childId == childId && p.completed)
        .toList();

    if (childProgress.isEmpty) return 0;

    final totalScore = childProgress.fold<int>(
      0,
      (sum, p) => sum + p.highestScore,
    );

    return totalScore / childProgress.length;
  }
}
