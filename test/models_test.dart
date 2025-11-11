// Tests for data models

import 'package:flutter_test/flutter_test.dart';
import 'package:aprendo_jugando/models/user.dart';
import 'package:aprendo_jugando/models/child.dart';
import 'package:aprendo_jugando/models/subject.dart';
import 'package:aprendo_jugando/models/topic.dart';
import 'package:aprendo_jugando/models/activity.dart';
import 'package:aprendo_jugando/models/progress.dart';
import 'package:aprendo_jugando/models/gamification.dart';

void main() {
  group('User Model Tests', () {
    test('User can be created with required fields', () {
      final user = User(
        id: 'user1',
        email: 'test@example.com',
        firstName: 'Juan',
        lastName: 'Pérez',
        userType: 'parent',
        preferences: UserPreferences(),
        createdAt: DateTime.now(),
      );

      expect(user.id, 'user1');
      expect(user.email, 'test@example.com');
      expect(user.fullName, 'Juan Pérez');
      expect(user.userType, 'parent');
    });

    test('User serialization works correctly', () {
      final user = User(
        id: 'user1',
        email: 'test@example.com',
        firstName: 'Juan',
        lastName: 'Pérez',
        userType: 'parent',
        preferences: UserPreferences(),
        createdAt: DateTime.now(),
      );

      final json = user.toJson();
      final userFromJson = User.fromJson(json);

      expect(userFromJson.id, user.id);
      expect(userFromJson.email, user.email);
      expect(userFromJson.firstName, user.firstName);
    });
  });

  group('Child Model Tests', () {
    test('Child can be created with required fields', () {
      final child = Child(
        id: 'child1',
        parentId: 'parent1',
        username: 'sofia',
        displayName: 'Sofía',
        dateOfBirth: DateTime(2016, 5, 15),
        grade: 2,
        pin: '1234',
        avatar: AvatarConfig(baseType: 'girl1'),
        preferences: ChildPreferences(),
      );

      expect(child.id, 'child1');
      expect(child.displayName, 'Sofía');
      expect(child.grade, 2);
      expect(child.username, 'sofia');
    });

    test('Child age calculation is correct', () {
      final child = Child(
        id: 'child1',
        parentId: 'parent1',
        username: 'test',
        displayName: 'Test',
        dateOfBirth: DateTime(2016, 1, 1),
        grade: 2,
        pin: '1234',
        avatar: AvatarConfig(baseType: 'boy1'),
        preferences: ChildPreferences(),
      );

      final expectedAge = DateTime.now().year - 2016;
      expect(child.age, expectedAge);
    });

    test('Child serialization works correctly', () {
      final child = Child(
        id: 'child1',
        parentId: 'parent1',
        username: 'sofia',
        displayName: 'Sofía',
        dateOfBirth: DateTime(2016, 5, 15),
        grade: 2,
        pin: '1234',
        avatar: AvatarConfig(baseType: 'girl1'),
        preferences: ChildPreferences(),
      );

      final json = child.toJson();
      final childFromJson = Child.fromJson(json);

      expect(childFromJson.id, child.id);
      expect(childFromJson.displayName, child.displayName);
      expect(childFromJson.grade, child.grade);
    });
  });

  group('Subject Model Tests', () {
    test('Subject can be created', () {
      final subject = Subject(
        id: 'subject1',
        name: 'Matemáticas',
        description: 'Aprende números',
        icon: 'calculate',
        color: '#2196F3',
        order: 1,
      );

      expect(subject.name, 'Matemáticas');
      expect(subject.icon, 'calculate');
      expect(subject.order, 1);
    });
  });

  group('Topic Model Tests', () {
    test('Topic can be created', () {
      final topic = Topic(
        id: 'topic1',
        subjectId: 'subject1',
        name: 'Suma y Resta',
        description: 'Aprende operaciones básicas',
        grades: [1, 2, 3],
        estimatedMinutes: 60,
        order: 1,
        icon: 'add_circle',
      );

      expect(topic.name, 'Suma y Resta');
      expect(topic.grades, [1, 2, 3]);
    });

    test('Topic grade applicability works', () {
      final topic = Topic(
        id: 'topic1',
        subjectId: 'subject1',
        name: 'Suma y Resta',
        description: 'Aprende operaciones básicas',
        grades: [1, 2, 3],
        estimatedMinutes: 60,
        order: 1,
        icon: 'add_circle',
      );

      expect(topic.isApplicableForGrade(2), true);
      expect(topic.isApplicableForGrade(5), false);
    });
  });

  group('Activity Model Tests', () {
    test('Activity can be created', () {
      final activity = Activity(
        id: 'activity1',
        topicId: 'topic1',
        type: 'quiz',
        title: 'Sumas Básicas',
        instructions: 'Resuelve las sumas',
        difficulty: 2,
        recommendedGrade: 2,
        estimatedMinutes: 15,
        points: 100,
        content: {},
        createdAt: DateTime.now(),
      );

      expect(activity.title, 'Sumas Básicas');
      expect(activity.type, 'quiz');
      expect(activity.difficulty, 2);
    });

    test('QuizQuestion isCorrect works properly', () {
      final question = QuizQuestion(
        id: 'q1',
        text: '¿Cuánto es 2 + 2?',
        type: 'multiple_choice',
        options: ['3', '4', '5'],
        correctAnswer: '4',
        explanation: '2 + 2 = 4',
        points: 10,
      );

      expect(question.isCorrect('4'), true);
      expect(question.isCorrect('3'), false);
    });
  });

  group('Progress Model Tests', () {
    test('Progress can be created', () {
      final progress = Progress(
        id: 'progress1',
        childId: 'child1',
        activityId: 'activity1',
        status: 'completed',
        completed: true,
        highestScore: 90,
      );

      expect(progress.completed, true);
      expect(progress.highestScore, 90);
    });

    test('Progress average score calculation', () {
      final attempts = [
        Attempt(
          attemptNumber: 1,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          durationSeconds: 300,
          score: 70,
          pointsEarned: 70,
          coinsEarned: 35,
          experienceEarned: 70,
        ),
        Attempt(
          attemptNumber: 2,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          durationSeconds: 250,
          score: 90,
          pointsEarned: 90,
          coinsEarned: 45,
          experienceEarned: 90,
        ),
      ];

      final progress = Progress(
        id: 'progress1',
        childId: 'child1',
        activityId: 'activity1',
        status: 'completed',
        attemptsList: attempts,
      );

      expect(progress.averageScore, 80);
    });
  });

  group('Gamification Model Tests', () {
    test('Gamification can be created', () {
      final gamification = Gamification(
        id: 'gamif1',
        childId: 'child1',
        totalPoints: 350,
        currentCoins: 125,
        experiencePoints: 450,
        currentLevel: 5,
        experienceForNextLevel: 500,
        streak: StreakInfo(currentStreak: 5, longestStreak: 7),
      );

      expect(gamification.currentLevel, 5);
      expect(gamification.totalPoints, 350);
      expect(gamification.streak.currentStreak, 5);
    });

    test('Progress to next level calculation', () {
      final gamification = Gamification(
        id: 'gamif1',
        childId: 'child1',
        experiencePoints: 450,
        currentLevel: 5,
        experienceForNextLevel: 500,
        streak: StreakInfo(),
      );

      // Should be between 0 and 1
      expect(gamification.progressToNextLevel >= 0, true);
      expect(gamification.progressToNextLevel <= 1, true);
    });
  });

  group('Achievement Model Tests', () {
    test('Achievement can be created', () {
      final achievement = Achievement(
        id: 'ach1',
        code: 'FIRST_VICTORY',
        name: 'Primera Victoria',
        description: 'Completaste tu primera actividad',
        iconUrl: 'trophy',
        category: 'bronze',
        rewardPoints: 50,
        unlockedDate: DateTime.now(),
      );

      expect(achievement.name, 'Primera Victoria');
      expect(achievement.category, 'bronze');
      expect(achievement.rewardPoints, 50);
    });
  });
}
