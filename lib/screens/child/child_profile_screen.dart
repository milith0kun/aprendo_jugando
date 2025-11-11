import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

class ChildProfileScreen extends StatefulWidget {
  const ChildProfileScreen({Key? key}) : super(key: key);

  @override
  State<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends State<ChildProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final child = authProvider.currentChild;
    final gamification = progressProvider.gamification;

    if (child == null) {
      return const Scaffold(
        body: Center(child: Text('Error: No hay sesión activa')),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.secondaryColor,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            child.displayName[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          child.displayName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (gamification != null)
                          Text(
                            'Nivel ${gamification.currentLevel}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Progreso', icon: Icon(Icons.trending_up)),
                  Tab(text: 'Logros', icon: Icon(Icons.emoji_events)),
                  Tab(text: 'Estadísticas', icon: Icon(Icons.bar_chart)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildProgressTab(context, child, gamification),
            _buildAchievementsTab(context, gamification),
            _buildStatsTab(context, child, progressProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab(BuildContext context, dynamic child, dynamic gamification) {
    if (gamification == null) {
      return const Center(child: Text('Cargando...'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nivel ${gamification.currentLevel}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star,
                          color: AppTheme.accentColor,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Experiencia',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${gamification.experiencePoints} / ${gamification.experienceForNextLevel} XP',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: gamification.progressToNextLevel,
                      minHeight: 16,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Faltan ${gamification.experienceForNextLevel - gamification.experiencePoints} XP para el siguiente nivel',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Puntos Totales',
                  '${gamification.totalPoints}',
                  Icons.stars,
                  AppTheme.accentColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Monedas',
                  '${gamification.currentCoins}',
                  Icons.monetization_on,
                  AppTheme.accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Racha Actual',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${gamification.streak.currentStreak} días consecutivos',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: AppTheme.accentColor),
                      const SizedBox(width: 8),
                      Text(
                        'Mejor racha: ${gamification.streak.longestStreak} días',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (gamification.streak.lastActivityDate != null)
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Última actividad: ${DateFormat('dd/MM/yyyy HH:mm').format(gamification.streak.lastActivityDate!)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  _buildStreakCalendar(gamification.streak.currentStreak),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(BuildContext context, dynamic gamification) {
    if (gamification == null) {
      return const Center(child: Text('Cargando...'));
    }

    final unlocked = gamification.unlockedAchievements;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (unlocked.isNotEmpty) ...[
            Text(
              'Logros Desbloqueados (${unlocked.length})',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ...unlocked.map((achievement) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getAchievementColor(achievement.category).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      color: _getAchievementColor(achievement.category),
                      size: 32,
                    ),
                  ),
                  title: Text(
                    achievement.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(achievement.description),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.stars, size: 16, color: AppTheme.accentColor),
                          const SizedBox(width: 4),
                          Text(
                            '+${achievement.rewardPoints} pts',
                            style: TextStyle(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy').format(achievement.unlockedDate),
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      achievement.category.toUpperCase(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: _getAchievementColor(achievement.category).withOpacity(0.2),
                  ),
                ),
              );
            }),
          ] else ...[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Icon(Icons.emoji_events, size: 100, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Aún no tienes logros',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¡Completa actividades para desbloquearlos!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsTab(
    BuildContext context,
    dynamic child,
    ProgressProvider progressProvider,
  ) {
    final stats = progressProvider.getCompletionStats(child.id);
    final avgScore = progressProvider.getAverageScore(child.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen General',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Completadas',
                  '${stats['completed']}',
                  Icons.check_circle,
                  AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'En Progreso',
                  '${stats['inProgress']}',
                  Icons.hourglass_empty,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Promedio',
                  '${avgScore.toStringAsFixed(0)}%',
                  Icons.show_chart,
                  AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Total',
                  '${stats['total']}',
                  Icons.assignment,
                  Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información Personal',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Nombre', child.displayName),
                  _buildInfoRow('Usuario', child.username),
                  _buildInfoRow('Edad', '${child.age} años'),
                  _buildInfoRow('Grado', '${child.grade}°'),
                  _buildInfoRow(
                    'Tiempo Total',
                    '${child.totalMinutes} minutos',
                  ),
                  if (child.lastActivity != null)
                    _buildInfoRow(
                      'Última Actividad',
                      DateFormat('dd/MM/yyyy HH:mm').format(child.lastActivity!),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCalendar(int currentStreak) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final isActive = index < currentStreak;
        return Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.orange.withOpacity(0.2)
                    : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                isActive ? Icons.local_fire_department : Icons.circle_outlined,
                color: isActive ? Colors.orange : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'D${index + 1}',
              style: TextStyle(
                fontSize: 10,
                color: isActive ? Colors.orange : Colors.grey[400],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Color _getAchievementColor(String category) {
    switch (category.toLowerCase()) {
      case 'bronze':
        return const Color(0xFFCD7F32);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'gold':
        return const Color(0xFFFFD700);
      case 'platinum':
        return const Color(0xFFE5E4E2);
      default:
        return AppTheme.accentColor;
    }
  }
}
