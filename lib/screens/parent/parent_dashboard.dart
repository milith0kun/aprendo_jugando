import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  String? _selectedChildId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final children = authProvider.getChildren();
      if (children.isNotEmpty) {
        setState(() {
          _selectedChildId = children.first.id;
        });
        Provider.of<ProgressProvider>(context, listen: false)
            .loadChildProgress(_selectedChildId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final children = authProvider.getChildren();

    if (children.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.child_care, size: 100, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('No tienes niños registrados'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.of(context).pushNamed('/add-child');
                  if (result == true && mounted) {
                    setState(() {});
                  }
                },
                child: const Text('Agregar Niño'),
              ),
            ],
          ),
        ),
      );
    }

    final selectedChild = children.firstWhere((c) => c.id == _selectedChildId);
    final stats = progressProvider.getCompletionStats(_selectedChildId!);
    final avgScore = progressProvider.getAverageScore(_selectedChildId!);
    final gamification = progressProvider.gamification;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, ${authProvider.currentUser?.firstName ?? ""}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              if (children.length > 1)
                DropdownButtonFormField<String>(
                  value: _selectedChildId,
                  decoration: const InputDecoration(
                    labelText: 'Selecciona un niño',
                  ),
                  items: children.map((child) {
                    return DropdownMenuItem(
                      value: child.id,
                      child: Text(child.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedChildId = value;
                      });
                      progressProvider.loadChildProgress(value);
                    }
                  },
                ),
              const SizedBox(height: 24),
              Text(
                'Resumen de ${selectedChild.displayName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    context,
                    'Nivel',
                    '${gamification?.currentLevel ?? 1}',
                    Icons.star,
                    AppTheme.accentColor,
                  ),
                  _buildStatCard(
                    context,
                    'Racha',
                    '${gamification?.streak.currentStreak ?? 0} días',
                    Icons.local_fire_department,
                    Colors.orange,
                  ),
                  _buildStatCard(
                    context,
                    'Actividades',
                    '${stats['completed'] ?? 0}/${stats['total'] ?? 0}',
                    Icons.task_alt,
                    AppTheme.secondaryColor,
                  ),
                  _buildStatCard(
                    context,
                    'Promedio',
                    '${avgScore.toStringAsFixed(0)}%',
                    Icons.show_chart,
                    AppTheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información del Niño',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Nombre', selectedChild.displayName),
                      _buildInfoRow('Grado', '${selectedChild.grade}°'),
                      _buildInfoRow('Edad', '${selectedChild.age} años'),
                      _buildInfoRow(
                        'Última actividad',
                        selectedChild.lastActivity != null
                            ? DateFormat('dd/MM/yyyy HH:mm')
                                .format(selectedChild.lastActivity!)
                            : 'Nunca',
                      ),
                      _buildInfoRow(
                        'Tiempo total',
                        '${selectedChild.totalMinutes} minutos',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (gamification != null && gamification.unlockedAchievements.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logros Recientes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ...gamification.unlockedAchievements.take(3).map((achievement) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.emoji_events, color: AppTheme.accentColor),
                          title: Text(achievement.name),
                          subtitle: Text(achievement.description),
                          trailing: Text(
                            DateFormat('dd/MM').format(achievement.unlockedDate),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/add-child');
          if (result == true && mounted) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Agregar Niño',
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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
}
