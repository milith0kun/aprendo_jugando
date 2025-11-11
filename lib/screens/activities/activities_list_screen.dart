import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../config/app_theme.dart';

class ActivitiesListScreen extends StatefulWidget {
  final String topicId;

  const ActivitiesListScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  State<ActivitiesListScreen> createState() => _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends State<ActivitiesListScreen> {
  List<dynamic> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final activities = await contentProvider.getActivities(widget.topicId);

    setState(() {
      _activities = activities;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _activities.isEmpty
              ? const Center(child: Text('No hay actividades disponibles'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    final activity = _activities[index];
                    return _buildActivityCard(context, activity);
                  },
                ),
    );
  }

  Widget _buildActivityCard(BuildContext context, dynamic activity) {
    final authProvider = Provider.of<AuthProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final childId = authProvider.currentChild?.id;

    final progress = childId != null
        ? progressProvider.getProgressForActivity(childId, activity.id)
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          String route;
          switch (activity.type) {
            case 'quiz':
              route = '/quiz-activity';
              break;
            case 'matching':
              route = '/matching-activity';
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tipo de actividad "${activity.type}" no implementado'),
                ),
              );
              return;
          }

          Navigator.of(context).pushNamed(
            route,
            arguments: {'activityId': activity.id},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          activity.instructions,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (progress != null && progress.completed)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.star,
                    'Dificultad ${activity.difficulty}/5',
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.timer,
                    '${activity.estimatedMinutes} min',
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.monetization_on,
                    '+${activity.points} pts',
                  ),
                ],
              ),
              if (progress != null && progress.highestScore > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Mejor puntuación: ${progress.highestScore}%',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(
                      3,
                      (i) => Icon(
                        i < (progress.highestScore / 33).floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppTheme.accentColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
