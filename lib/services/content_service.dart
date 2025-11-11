import '../models/subject.dart';
import '../models/topic.dart';
import '../models/activity.dart';
import 'mock_data_service.dart';

class ContentService {
  // Get all subjects
  Future<List<Subject>> getSubjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(MockDataService.mockSubjects);
  }

  // Get topics by subject
  Future<List<Topic>> getTopicsBySubject(String subjectId, {int? grade}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    var topics = MockDataService.mockTopics
        .where((t) => t.subjectId == subjectId)
        .toList();

    if (grade != null) {
      topics = topics.where((t) => t.isApplicableForGrade(grade)).toList();
    }

    topics.sort((a, b) => a.order.compareTo(b.order));
    return topics;
  }

  // Get topic by ID
  Future<Topic?> getTopicById(String topicId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockDataService.mockTopics.firstWhere((t) => t.id == topicId);
    } catch (e) {
      return null;
    }
  }

  // Get activities by topic
  Future<List<Activity>> getActivitiesByTopic(
    String topicId, {
    int? grade,
    int? difficulty,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    var activities = MockDataService.mockActivities
        .where((a) => a.topicId == topicId)
        .toList();

    if (grade != null) {
      activities =
          activities.where((a) => a.recommendedGrade == grade).toList();
    }

    if (difficulty != null) {
      activities = activities.where((a) => a.difficulty == difficulty).toList();
    }

    return activities;
  }

  // Get activity by ID
  Future<Activity?> getActivityById(String activityId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return MockDataService.mockActivities
          .firstWhere((a) => a.id == activityId);
    } catch (e) {
      return null;
    }
  }

  // Get recommended activities for a child
  Future<List<Activity>> getRecommendedActivities(
    String childId,
    int grade,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, this would use AI/ML to recommend activities
    // For now, return activities matching the child's grade
    return MockDataService.mockActivities
        .where((a) => a.recommendedGrade == grade)
        .take(5)
        .toList();
  }
}
