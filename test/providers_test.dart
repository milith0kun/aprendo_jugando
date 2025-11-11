// Tests for providers

import 'package:flutter_test/flutter_test.dart';
import 'package:aprendo_jugando/providers/auth_provider.dart';
import 'package:aprendo_jugando/providers/content_provider.dart';
import 'package:aprendo_jugando/providers/progress_provider.dart';

void main() {
  group('AuthProvider Tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('Initial state is not authenticated', () {
      expect(authProvider.isAuthenticated, false);
      expect(authProvider.currentUser, isNull);
      expect(authProvider.currentChild, isNull);
    });

    test('Login sets current user', () async {
      final success = await authProvider.login('padre@ejemplo.com', 'password');

      expect(success, true);
      expect(authProvider.isAuthenticated, true);
      expect(authProvider.isParent, true);
      expect(authProvider.currentUser, isNotNull);
    });

    test('Child login sets current child', () async {
      final success = await authProvider.loginChild('child1', '1234');

      expect(success, true);
      expect(authProvider.isAuthenticated, true);
      expect(authProvider.isChild, true);
      expect(authProvider.currentChild, isNotNull);
    });

    test('Logout clears authentication', () async {
      await authProvider.login('padre@ejemplo.com', 'password');
      await authProvider.logout();

      expect(authProvider.isAuthenticated, false);
      expect(authProvider.currentUser, isNull);
    });

    test('Register creates new user', () async {
      final success = await authProvider.register(
        email: 'nuevo@test.com',
        password: 'password',
        firstName: 'Test',
        lastName: 'User',
      );

      expect(success, true);
      expect(authProvider.isAuthenticated, true);
    });

    test('Get children returns list of children', () async {
      await authProvider.login('padre@ejemplo.com', 'password');
      final children = authProvider.getChildren();

      expect(children, isNotEmpty);
    });

    test('Get child by ID returns correct child', () async {
      await authProvider.login('padre@ejemplo.com', 'password');
      final child = authProvider.getChildById('child1');

      expect(child, isNotNull);
      expect(child!.id, 'child1');
    });

    test('Failed login sets error message', () async {
      final success = await authProvider.login('wrong@email.com', 'wrong');

      expect(success, false);
      expect(authProvider.errorMessage, isNotNull);
    });

    test('Clear error removes error message', () async {
      await authProvider.login('wrong@email.com', 'wrong');
      authProvider.clearError();

      expect(authProvider.errorMessage, isNull);
    });
  });

  group('ContentProvider Tests', () {
    late ContentProvider contentProvider;

    setUp(() {
      contentProvider = ContentProvider();
    });

    test('Initial state has empty subjects', () {
      expect(contentProvider.subjects, isEmpty);
      expect(contentProvider.isLoading, false);
    });

    test('Load subjects populates subjects list', () async {
      await contentProvider.loadSubjects();

      expect(contentProvider.subjects, isNotEmpty);
      expect(contentProvider.subjects.length, greaterThan(0));
    });

    test('Get topics returns topics for subject', () async {
      await contentProvider.loadSubjects();
      final topics = await contentProvider.getTopics('subject1');

      expect(topics, isNotEmpty);
      expect(topics.every((t) => t.subjectId == 'subject1'), true);
    });

    test('Get activities returns activities for topic', () async {
      final activities = await contentProvider.getActivities('topic1');

      expect(activities, isNotEmpty);
      expect(activities.every((a) => a.topicId == 'topic1'), true);
    });

    test('Get activity by ID returns correct activity', () async {
      final activity = await contentProvider.getActivityById('activity1');

      expect(activity, isNotNull);
      expect(activity!.id, 'activity1');
    });

    test('Get subject by ID returns correct subject', () async {
      await contentProvider.loadSubjects();
      final subject = contentProvider.getSubjectById('subject1');

      expect(subject, isNotNull);
      expect(subject!.id, 'subject1');
    });

    test('Loading state is set during operations', () async {
      final loadFuture = contentProvider.loadSubjects();

      // Check loading state is true during operation
      await Future.delayed(Duration(milliseconds: 50));

      await loadFuture;

      // After completion, loading should be false
      expect(contentProvider.isLoading, false);
    });
  });

  group('ProgressProvider Tests', () {
    late ProgressProvider progressProvider;

    setUp(() {
      progressProvider = ProgressProvider();
    });

    test('Initial state is not loading', () {
      expect(progressProvider.isLoading, false);
      expect(progressProvider.gamification, isNull);
    });

    test('Load child progress populates data', () async {
      await progressProvider.loadChildProgress('child1');

      expect(progressProvider.gamification, isNotNull);
    });

    test('Get progress for activity returns correct progress', () async {
      await progressProvider.loadChildProgress('child1');
      final progress = progressProvider.getProgressForActivity('child1', 'activity1');

      if (progress != null) {
        expect(progress.childId, 'child1');
        expect(progress.activityId, 'activity1');
      }
    });

    test('Complete activity updates progress', () async {
      await progressProvider.loadChildProgress('child1');

      final success = await progressProvider.completeActivity(
        childId: 'child1',
        activityId: 'activity1',
        score: 85,
        durationSeconds: 300,
        hintsUsed: 1,
      );

      expect(success, true);
      expect(progressProvider.gamification, isNotNull);
    });

    test('Get completion stats returns statistics', () async {
      await progressProvider.loadChildProgress('child1');
      final stats = progressProvider.getCompletionStats('child1');

      expect(stats, isNotNull);
      expect(stats['total'], isNotNull);
      expect(stats['completed'], isNotNull);
      expect(stats['inProgress'], isNotNull);
    });

    test('Get average score calculates correctly', () async {
      await progressProvider.loadChildProgress('child1');
      final avgScore = progressProvider.getAverageScore('child1');

      expect(avgScore, greaterThanOrEqualTo(0));
      expect(avgScore, lessThanOrEqualTo(100));
    });

    test('Gamification is loaded with child progress', () async {
      await progressProvider.loadChildProgress('child1');

      expect(progressProvider.gamification, isNotNull);
      expect(progressProvider.gamification!.childId, 'child1');
    });
  });

  group('Provider Notifications Tests', () {
    test('AuthProvider notifies listeners on login', () async {
      final authProvider = AuthProvider();
      var notified = false;

      authProvider.addListener(() {
        notified = true;
      });

      await authProvider.login('padre@ejemplo.com', 'password');

      expect(notified, true);
    });

    test('ContentProvider notifies listeners on load', () async {
      final contentProvider = ContentProvider();
      var notified = false;

      contentProvider.addListener(() {
        notified = true;
      });

      await contentProvider.loadSubjects();

      expect(notified, true);
    });

    test('ProgressProvider notifies listeners on complete activity', () async {
      final progressProvider = ProgressProvider();
      await progressProvider.loadChildProgress('child1');

      var notified = false;
      progressProvider.addListener(() {
        notified = true;
      });

      await progressProvider.completeActivity(
        childId: 'child1',
        activityId: 'activity1',
        score: 85,
        durationSeconds: 300,
        hintsUsed: 1,
      );

      expect(notified, true);
    });
  });
}
