// Tests for services

import 'package:flutter_test/flutter_test.dart';
import 'package:aprendo_jugando/services/auth_service.dart';
import 'package:aprendo_jugando/services/content_service.dart';
import 'package:aprendo_jugando/services/progress_service.dart';
import 'package:aprendo_jugando/services/mock_data_service.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Login with valid credentials returns user', () async {
      final user = await authService.login('padre@ejemplo.com', 'password');

      expect(user, isNotNull);
      expect(user!.email, 'padre@ejemplo.com');
    });

    test('Login saves auth token', () async {
      await authService.login('padre@ejemplo.com', 'password');

      final isLoggedIn = await authService.isLoggedIn();
      expect(isLoggedIn, true);
    });

    test('Logout clears auth token', () async {
      await authService.login('padre@ejemplo.com', 'password');
      await authService.logout();

      final isLoggedIn = await authService.isLoggedIn();
      expect(isLoggedIn, false);
    });

    test('Register creates new user', () async {
      final user = await authService.register(
        email: 'nuevo@ejemplo.com',
        password: 'password',
        firstName: 'Nuevo',
        lastName: 'Usuario',
        userType: 'parent',
      );

      expect(user, isNotNull);
      expect(user!.email, 'nuevo@ejemplo.com');
      expect(user.firstName, 'Nuevo');
    });

    test('Child login with correct PIN succeeds', () async {
      final child = await authService.loginChild('child1', '1234');

      expect(child, isNotNull);
      expect(child!.id, 'child1');
    });

    test('Child login with incorrect PIN fails', () async {
      expect(
        () async => await authService.loginChild('child1', '0000'),
        throwsException,
      );
    });

    test('Get current user returns logged in user', () async {
      await authService.login('padre@ejemplo.com', 'password');
      final user = await authService.getCurrentUser();

      expect(user, isNotNull);
      expect(user!.email, 'padre@ejemplo.com');
    });
  });

  group('ContentService Tests', () {
    late ContentService contentService;

    setUp(() {
      contentService = ContentService();
    });

    test('Get all subjects returns list', () async {
      final subjects = await contentService.getSubjects();

      expect(subjects, isNotEmpty);
      expect(subjects.length, greaterThan(0));
    });

    test('Get topics by subject returns correct topics', () async {
      final topics = await contentService.getTopicsBySubject('subject1');

      expect(topics, isNotEmpty);
      expect(topics.every((t) => t.subjectId == 'subject1'), true);
    });

    test('Get topics filtered by grade works', () async {
      final topics = await contentService.getTopicsBySubject('subject1', grade: 2);

      expect(topics, isNotEmpty);
      expect(topics.every((t) => t.grades.contains(2)), true);
    });

    test('Get activities by topic returns correct activities', () async {
      final activities = await contentService.getActivitiesByTopic('topic1');

      expect(activities, isNotEmpty);
      expect(activities.every((a) => a.topicId == 'topic1'), true);
    });

    test('Get activity by ID returns correct activity', () async {
      final activity = await contentService.getActivityById('activity1');

      expect(activity, isNotNull);
      expect(activity!.id, 'activity1');
    });

    test('Get topic by ID returns correct topic', () async {
      final topic = await contentService.getTopicById('topic1');

      expect(topic, isNotNull);
      expect(topic!.id, 'topic1');
    });
  });

  group('ProgressService Tests', () {
    late ProgressService progressService;

    setUp(() {
      progressService = ProgressService();
    });

    test('Get progress for child returns progress list', () async {
      final progress = await progressService.getChildProgress('child1');

      expect(progress, isNotNull);
      expect(progress, isList);
    });

    test('Save activity completion creates progress', () async {
      final progress = await progressService.saveActivityCompletion(
        childId: 'child1',
        activityId: 'activity1',
        score: 85,
        durationSeconds: 300,
        hintsUsed: 1,
      );

      expect(progress, isNotNull);
      expect(progress.childId, 'child1');
      expect(progress.activityId, 'activity1');
    });

    test('Save activity completion updates gamification', () async {
      final gamificationBefore = await progressService.getGamification('child1');
      final pointsBefore = gamificationBefore?.totalPoints ?? 0;

      await progressService.saveActivityCompletion(
        childId: 'child1',
        activityId: 'activity1',
        score: 85,
        durationSeconds: 300,
        hintsUsed: 1,
      );

      final gamificationAfter = await progressService.getGamification('child1');
      expect(gamificationAfter!.totalPoints, greaterThan(pointsBefore));
    });

    test('Get gamification returns gamification data', () async {
      final gamification = await progressService.getGamification('child1');

      expect(gamification, isNotNull);
      expect(gamification!.childId, 'child1');
    });

    test('Get progress for specific activity', () async {
      final progress = await progressService.getProgress('child1', 'activity1');

      if (progress != null) {
        expect(progress.childId, 'child1');
        expect(progress.activityId, 'activity1');
      }
    });
  });

  group('MockDataService Tests', () {
    test('Mock users are available', () {
      expect(MockDataService.mockUsers, isNotEmpty);
      expect(MockDataService.mockUsers.length, greaterThan(0));
    });

    test('Mock children are available', () {
      expect(MockDataService.mockChildren, isNotEmpty);
      expect(MockDataService.mockChildren.length, greaterThan(0));
    });

    test('Mock subjects are available', () {
      expect(MockDataService.mockSubjects, isNotEmpty);
      expect(MockDataService.mockSubjects.length, equals(2));
    });

    test('Mock topics are available', () {
      expect(MockDataService.mockTopics, isNotEmpty);
      expect(MockDataService.mockTopics.length, greaterThanOrEqualTo(6));
    });

    test('Mock activities are available', () {
      expect(MockDataService.mockActivities, isNotEmpty);
      expect(MockDataService.mockActivities.length, greaterThanOrEqualTo(4));
    });

    test('Mock progress data is available', () {
      expect(MockDataService.mockProgress, isNotNull);
      expect(MockDataService.mockProgress, isList);
    });

    test('Mock gamification data is available', () {
      expect(MockDataService.mockGamification, isNotEmpty);
      expect(MockDataService.mockGamification.length, greaterThan(0));
    });
  });
}
