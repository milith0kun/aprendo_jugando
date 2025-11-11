import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contentProvider = Provider.of<ContentProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final progressProvider = Provider.of<ProgressProvider>(context, listen: false);

      contentProvider.loadSubjects();
      if (authProvider.currentChild != null) {
        progressProvider.loadChildProgress(authProvider.currentChild!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final contentProvider = Provider.of<ContentProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final child = authProvider.currentChild;
    final gamification = progressProvider.gamification;

    if (child == null) {
      return const Scaffold(
        body: Center(child: Text('Error: No hay sesión activa')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.accentColor.withOpacity(0.2),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                child.displayName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, ${child.displayName}!',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Nivel ${gamification?.currentLevel ?? 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.monetization_on, color: AppTheme.accentColor),
              const SizedBox(width: 4),
              Text(
                '${gamification?.currentCoins ?? 0}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (gamification != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.accentColor.withOpacity(0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nivel ${gamification.currentLevel}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${gamification.experiencePoints}/${gamification.experienceForNextLevel} XP',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: gamification.progressToNextLevel,
                      minHeight: 12,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      Text('Racha: ${gamification.streak.currentStreak} días'),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: contentProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : contentProvider.subjects.isEmpty
                    ? const Center(child: Text('No hay áreas disponibles'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: contentProvider.subjects.length,
                        itemBuilder: (context, index) {
                          final subject = contentProvider.subjects[index];
                          return _buildSubjectCard(context, subject);
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 1 || index == 2) {
            // Navigate to profile
            Navigator.of(context).pushNamed('/child-profile');
          }
        },
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, dynamic subject) {
    Color cardColor;
    if (subject.name == 'Matemáticas') {
      cardColor = AppTheme.mathColor;
    } else if (subject.name == 'Lengua') {
      cardColor = AppTheme.languageColor;
    } else {
      cardColor = AppTheme.primaryColor;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/topics',
          arguments: {'subjectId': subject.id},
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: cardColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconData(subject.icon),
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subject.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cardColor,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subject.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'calculate':
        return Icons.calculate;
      case 'menu_book':
        return Icons.menu_book;
      default:
        return Icons.school;
    }
  }
}
