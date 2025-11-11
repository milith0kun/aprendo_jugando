import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';
import '../../widgets/celebration_confetti.dart';
import '../../widgets/animated_progress_bar.dart';

class CompletionScreen extends StatefulWidget {
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
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();

    // Animación de rebote para el ícono principal
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );

    // Animación de fade in para el contenido
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Iniciar animaciones
    _bounceController.forward();
    _fadeController.forward();

    // Mostrar confetti si el score es bueno
    if (widget.score >= 70) {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _showConfetti = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final gamification = progressProvider.gamification;

    // Determinar mensaje y estilo según puntuación
    final resultData = _getResultData(widget.score);

    final stars = (widget.score / 33).floor().clamp(0, 3);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Stack(
          children: [
            // Confetti de celebración
            if (_showConfetti)
              Positioned.fill(
                child: CelebrationConfetti(
                  show: _showConfetti,
                  numberOfParticles: widget.score >= 90 ? 80 : 50,
                ),
              ),

            // Contenido principal
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Ícono principal animado
                        ScaleTransition(
                          scale: _bounceAnimation,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: resultData['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: resultData['color'].withOpacity(0.3),
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              resultData['icon'],
                              size: 64,
                              color: resultData['color'],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Título de resultado con emoji
                        Text(
                          resultData['title'],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: resultData['color'],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          resultData['emoji'],
                          style: const TextStyle(fontSize: 48),
                        ),

                        const SizedBox(height: 8),

                        // Mensaje motivacional
                        Text(
                          resultData['message'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        // Estrellas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                index < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                                color: AppTheme.rewardColor,
                                size: 48,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Card de estadísticas
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppTheme.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppTheme.borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildStatRow(
                                context,
                                'Puntuación',
                                '${widget.score}%',
                                Icons.percent_rounded,
                                resultData['color'],
                              ),
                              const Divider(height: 32),
                              _buildStatRow(
                                context,
                                'Respuestas Correctas',
                                '${widget.correctAnswers}/${widget.totalQuestions}',
                                Icons.check_circle_rounded,
                                AppTheme.successColor,
                              ),
                              const Divider(height: 32),
                              _buildStatRow(
                                context,
                                'Tiempo',
                                _formatDuration(widget.duration),
                                Icons.timer_rounded,
                                AppTheme.primaryColor,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Recompensas
                        if (gamification != null) ...[
                          Text(
                            '🎁 Recompensas Ganadas',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildRewardCard(
                                context,
                                'XP',
                                '+${widget.score}',
                                Icons.trending_up_rounded,
                                AppTheme.successColor,
                              ),
                              _buildRewardCard(
                                context,
                                'Monedas',
                                '+${(widget.score / 2).round()}',
                                Icons.monetization_on_rounded,
                                AppTheme.rewardColor,
                              ),
                              _buildRewardCard(
                                context,
                                'Nivel',
                                '${gamification.currentLevel}',
                                Icons.star_rounded,
                                AppTheme.accentColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Progreso al siguiente nivel
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.primaryColor.withOpacity(0.1),
                                  AppTheme.successColor.withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Progreso al siguiente nivel',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${gamification.experiencePoints}/${gamification.experienceForNextLevel}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                AnimatedProgressBar(
                                  progress: gamification.progressToNextLevel,
                                  color: AppTheme.successColor,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),

                        // Botones de acción
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  side: BorderSide(
                                    color: AppTheme.borderColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.home_rounded),
                                    SizedBox(width: 8),
                                    Text('Inicio'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  backgroundColor: AppTheme.successColor,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Continuar'),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getResultData(int score) {
    if (score >= 90) {
      return {
        'title': '¡Excelente!',
        'emoji': '🌟',
        'message': '¡Eres increíble! Sigue así',
        'icon': Icons.emoji_events_rounded,
        'color': AppTheme.rewardColor,
      };
    } else if (score >= 70) {
      return {
        'title': '¡Muy bien!',
        'emoji': '🎉',
        'message': '¡Lo estás haciendo genial!',
        'icon': Icons.thumb_up_rounded,
        'color': AppTheme.successColor,
      };
    } else if (score >= 50) {
      return {
        'title': '¡Buen trabajo!',
        'emoji': '😊',
        'message': 'Vas por buen camino',
        'icon': Icons.sentiment_satisfied_rounded,
        'color': AppTheme.primaryColor,
      };
    } else {
      return {
        'title': '¡Sigue intentando!',
        'emoji': '💪',
        'message': 'La práctica hace al maestro',
        'icon': Icons.favorite_rounded,
        'color': AppTheme.accentColor,
      };
    }
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
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
