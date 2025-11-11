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
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header minimalista
            _buildMinimalistHeader(child, gamification),

            // Progress card limpia
            if (gamification != null)
              _buildProgressCard(context, gamification),

            // Sección de materias
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Qué quieres aprender hoy?',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),

            // Grid de materias
            Expanded(
              child: contentProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : contentProvider.subjects.isEmpty
                      ? const Center(child: Text('No hay áreas disponibles'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(24),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: contentProvider.subjects.length,
                          itemBuilder: (context, index) {
                            final subject = contentProvider.subjects[index];
                            return _buildMinimalistSubjectCard(context, subject);
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildMinimalistBottomNav(context, authProvider),
    );
  }

  Widget _buildMinimalistHeader(dynamic child, dynamic gamification) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Avatar simple
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                child.displayName[0].toUpperCase(),
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Información del niño
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, ${child.displayName}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.star_rounded,
                      label: 'Nivel ${gamification?.currentLevel ?? 1}',
                      color: AppTheme.accentColor,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      icon: Icons.monetization_on_rounded,
                      label: '${gamification?.currentCoins ?? 0}',
                      color: AppTheme.rewardColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context, dynamic gamification) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado de progreso
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu progreso',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${gamification.experiencePoints}/${gamification.experienceForNextLevel} XP',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Barra de progreso minimalista
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: gamification.progressToNextLevel,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Estadísticas
          Row(
            children: [
              _buildStatItem(
                icon: Icons.local_fire_department_rounded,
                value: '${gamification.streak.currentStreak}',
                label: 'días de racha',
                color: AppTheme.dangerColor,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                icon: Icons.emoji_events_rounded,
                value: '${gamification.unlockedAchievements.length}',
                label: 'logros',
                color: AppTheme.rewardColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMinimalistSubjectCard(BuildContext context, dynamic subject) {
    Color cardColor;

    if (subject.name == 'Matemáticas') {
      cardColor = AppTheme.mathColor;
    } else if (subject.name == 'Lengua') {
      cardColor = AppTheme.languageColor;
    } else {
      cardColor = AppTheme.primaryColor;
    }

    return Hero(
      tag: 'subject_${subject.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/topics',
              arguments: {'subjectId': subject.id},
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.borderColor,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícono minimalista
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getIconData(subject.icon),
                      size: 32,
                      color: cardColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nombre de la materia
                  Text(
                    subject.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // Descripción
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
        ),
      ),
    );
  }

  Widget _buildMinimalistBottomNav(BuildContext context, AuthProvider authProvider) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          top: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Inicio', true, () {}),
              _buildNavItem(Icons.emoji_events_rounded, 'Logros', false, () {}),
              _buildNavItem(Icons.person_rounded, 'Perfil', false, () {
                _showLogoutDialog(context, authProvider);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? AppTheme.primaryColor : AppTheme.textTertiary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppTheme.primaryColor : AppTheme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Quieres salir de tu cuenta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.dangerColor,
            ),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'calculate':
        return Icons.calculate_rounded;
      case 'menu_book':
        return Icons.menu_book_rounded;
      default:
        return Icons.school_rounded;
    }
  }
}
