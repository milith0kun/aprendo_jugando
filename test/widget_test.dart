// Tests for Aprendo Jugando application

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:aprendo_jugando/main.dart';
import 'package:aprendo_jugando/providers/auth_provider.dart';
import 'package:aprendo_jugando/providers/content_provider.dart';
import 'package:aprendo_jugando/providers/progress_provider.dart';
import 'package:aprendo_jugando/screens/splash_screen.dart';

void main() {
  group('App Initialization Tests', () {
    testWidgets('App loads with splash screen', (WidgetTester tester) async {
      await tester.pumpWidget(const AprendoJugandoApp());

      // Verify splash screen is displayed
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.text('Aprendo Jugando'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
    });

    testWidgets('Providers are initialized', (WidgetTester tester) async {
      await tester.pumpWidget(const AprendoJugandoApp());

      final context = tester.element(find.byType(MaterialApp));

      // Verify all providers are available
      expect(Provider.of<AuthProvider>(context, listen: false), isNotNull);
      expect(Provider.of<ContentProvider>(context, listen: false), isNotNull);
      expect(Provider.of<ProgressProvider>(context, listen: false), isNotNull);
    });

    testWidgets('Theme is correctly applied', (WidgetTester tester) async {
      await tester.pumpWidget(const AprendoJugandoApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.title, 'Aprendo Jugando');
      expect(materialApp.debugShowCheckedModeBanner, false);
      expect(materialApp.theme, isNotNull);
    });
  });

  group('Navigation Tests', () {
    testWidgets('Initial route is splash screen', (WidgetTester tester) async {
      await tester.pumpWidget(const AprendoJugandoApp());

      expect(find.byType(SplashScreen), findsOneWidget);
    });
  });

  group('Splash Screen Tests', () {
    testWidgets('Splash screen displays branding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ContentProvider()),
            ChangeNotifierProvider(create: (_) => ProgressProvider()),
          ],
          child: MaterialApp(home: SplashScreen()),
        ),
      );

      expect(find.text('Aprendo Jugando'), findsOneWidget);
      expect(find.text('Aprende mientras te diviertes'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
