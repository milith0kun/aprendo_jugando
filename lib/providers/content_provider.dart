import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../models/topic.dart';
import '../models/activity.dart';
import '../services/content_service.dart';

class ContentProvider extends ChangeNotifier {
  final ContentService _contentService = ContentService();

  List<Subject> _subjects = [];
  Map<String, List<Topic>> _topicsBySubject = {};
  Map<String, List<Activity>> _activitiesByTopic = {};
  bool _isLoading = false;

  List<Subject> get subjects => _subjects;
  bool get isLoading => _isLoading;

  Future<void> loadSubjects() async {
    _isLoading = true;
    notifyListeners();

    try {
      _subjects = await _contentService.getSubjects();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Topic>> getTopics(String subjectId, {int? grade}) async {
    if (_topicsBySubject.containsKey(subjectId)) {
      return _topicsBySubject[subjectId]!;
    }

    _isLoading = true;
    Future.microtask(() => notifyListeners());

    try {
      final topics = await _contentService.getTopicsBySubject(subjectId, grade: grade);
      _topicsBySubject[subjectId] = topics;
      return topics;
    } catch (e) {
      return [];
    } finally {
      _isLoading = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<List<Activity>> getActivities(String topicId) async {
    if (_activitiesByTopic.containsKey(topicId)) {
      return _activitiesByTopic[topicId]!;
    }

    _isLoading = true;
    Future.microtask(() => notifyListeners());

    try {
      final activities = await _contentService.getActivitiesByTopic(topicId);
      _activitiesByTopic[topicId] = activities;
      return activities;
    } catch (e) {
      return [];
    } finally {
      _isLoading = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<Activity?> getActivityById(String activityId) async {
    return await _contentService.getActivityById(activityId);
  }

  Subject? getSubjectById(String subjectId) {
    try {
      return _subjects.firstWhere((s) => s.id == subjectId);
    } catch (e) {
      return null;
    }
  }
}
