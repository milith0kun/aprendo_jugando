import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/content_provider.dart';
import 'providers/progress_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/child_login_screen.dart';
import 'screens/parent/parent_dashboard.dart';
import 'screens/parent/add_child_screen.dart';
import 'screens/child/child_home_screen.dart';
import 'screens/child/child_profile_screen.dart';
import 'screens/child/topics_screen.dart';
import 'screens/activities/activities_list_screen.dart';
import 'screens/activities/quiz_activity_screen.dart';
import 'screens/activities/completion_screen.dart';

void main() {
  runApp(const AprendoJugandoApp());
}

class AprendoJugandoApp extends StatelessWidget {
  const AprendoJugandoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: MaterialApp(
        title: 'Aprendo Jugando',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => const SplashScreen(),
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              );
            case '/register':
              return MaterialPageRoute(
                builder: (_) => const RegisterScreen(),
              );
            case '/child-login':
              return MaterialPageRoute(
                builder: (_) => const ChildLoginScreen(),
              );
            case '/parent-dashboard':
              return MaterialPageRoute(
                builder: (_) => const ParentDashboard(),
              );
            case '/add-child':
              return MaterialPageRoute(
                builder: (_) => const AddChildScreen(),
              );
            case '/child-home':
              return MaterialPageRoute(
                builder: (_) => const ChildHomeScreen(),
              );
            case '/child-profile':
              return MaterialPageRoute(
                builder: (_) => const ChildProfileScreen(),
              );
            case '/topics':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => TopicsScreen(
                  subjectId: args['subjectId'] as String,
                ),
              );
            case '/activities':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => ActivitiesListScreen(
                  topicId: args['topicId'] as String,
                ),
              );
            case '/quiz-activity':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => QuizActivityScreen(
                  activityId: args['activityId'] as String,
                ),
              );
            case '/completion':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => CompletionScreen(
                  score: args['score'] as int,
                  totalQuestions: args['totalQuestions'] as int,
                  correctAnswers: args['correctAnswers'] as int,
                  duration: args['duration'] as int,
                  activityTitle: args['activityTitle'] as String,
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const SplashScreen(),
              );
          }
        },
      ),
    );
  }
}
