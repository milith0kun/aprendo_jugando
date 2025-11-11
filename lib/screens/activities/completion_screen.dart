import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';

class CompletionScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int duration;
  final String activityTitle;

  const CompletionScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.duration,
    required this.activityTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final gamification = progressProvider.gamification;

    String message;
    IconData icon;
    Color color;

    if (score >= 90) {
      message = '¡Excelente!';
      icon = Icons.emoji_events;
      color = AppTheme.accentColor;
    } else if (score >= 70) {
      message = '¡Muy bien!';
      icon = Icons.thumb_up;
      color = AppTheme.secondaryColor;
    } else if (score >= 50) {
      message = '¡Buen intento!';
      icon = Icons.sentiment_satisfied;
      color = AppTheme.primaryColor;
    } else {
      message = '¡Sigue practicando!';
      icon = Icons.sentiment_neutral;
      color = Colors.orange;
    }

    final stars = (score / 33).floor().clamp(0, 3);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('¡Actividad Completada!'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Icon(
                  icon,
                  size: 100,
                  color: color,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: color,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < stars ? Icons.star : Icons.star_border,
                      color: AppTheme.accentColor,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildResultRow(
                          context,
                          'Puntuación',
                          '$score%',
                          Icons.percent,
                        ),
                        const Divider(height: 24),
                        _buildResultRow(
                          context,
                          'Preguntas Correctas',
                          '$correctAnswers/$totalQuestions',
                          Icons.check_circle,
                        ),
                        const Divider(height: 24),
                        _buildResultRow(
                          context,
                          'Tiempo',
                          _formatDuration(duration),
                          Icons.timer,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (gamification != null) ...[
                  Text(
                    'Recompensas',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRewardCard(
                        context,
                        'Nivel',
                        '${gamification.currentLevel}',
                        Icons.star,
                        AppTheme.accentColor,
                      ),
                      _buildRewardCard(
                        context,
                        'Experiencia',
                        '+$score XP',
                        Icons.trending_up,
                        AppTheme.primaryColor,
                      ),
                      _buildRewardCard(
                        context,
                        'Monedas',
                        '+${(score / 2).round()}',
                        Icons.monetization_on,
                        AppTheme.accentColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progreso al Nivel ${gamification.currentLevel + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '${gamification.experiencePoints}/${gamification.experienceForNextLevel}',
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
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppTheme.accentColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        child: const Text('Volver al Inicio'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Continuar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(BuildContext context, String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${remainingSeconds}s';
    }
    return '${remainingSeconds}s';
  }
}
