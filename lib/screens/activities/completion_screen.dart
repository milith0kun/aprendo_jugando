import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';

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

class _CompletionScreenState extends State<CompletionScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Trigger animations
    Future.delayed(const Duration(milliseconds: 300), () {
      _scaleController.forward();
      _slideController.forward();
      if (widget.score >= 70) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final gamification = progressProvider.gamification;

    String message;
    IconData icon;
    Color color;

    if (widget.score >= 90) {
      message = '¡Excelente!';
      icon = Icons.emoji_events;
      color = AppTheme.accentColor;
    } else if (widget.score >= 70) {
      message = '¡Muy bien!';
      icon = Icons.thumb_up;
      color = AppTheme.secondaryColor;
    } else if (widget.score >= 50) {
      message = '¡Buen intento!';
      icon = Icons.sentiment_satisfied;
      color = AppTheme.primaryColor;
    } else {
      message = '¡Sigue practicando!';
      icon = Icons.sentiment_neutral;
      color = Colors.orange;
    }

    final stars = (widget.score / 33).floor().clamp(0, 3);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
            ),
          ),
          title: const Text(
            '¡Actividad Completada!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 30,
                gravity: 0.2,
                shouldLoop: false,
                colors: const [
                  AppTheme.primaryColor,
                  AppTheme.secondaryColor,
                  AppTheme.accentColor,
                  Colors.purple,
                  Colors.pink,
                  Colors.orange,
                ],
              ),
            ),
            // Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Animated Icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              color.withOpacity(0.3),
                              color.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: 120,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Animated Message
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 8,
                              color: color.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Animated Stars
                    SlideTransition(
                      position: _slideAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => TweenAnimationBuilder(
                            duration: Duration(milliseconds: 400 + (index * 200)),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Transform.rotate(
                                  angle: (1 - value) * 2 * pi,
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                index < stars ? Icons.star : Icons.star_border,
                                color: AppTheme.accentColor,
                                size: 56,
                                shadows: index < stars
                                    ? [
                                        Shadow(
                                          color: AppTheme.accentColor.withOpacity(0.5),
                                          blurRadius: 12,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Results Card with animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withOpacity(0.1),
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: color.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              _buildResultRow(
                                context,
                                'Puntuación',
                                '${widget.score}%',
                                Icons.percent,
                                color,
                              ),
                              const Divider(height: 28),
                              _buildResultRow(
                                context,
                                'Preguntas Correctas',
                                '${widget.correctAnswers}/${widget.totalQuestions}',
                                Icons.check_circle,
                                AppTheme.secondaryColor,
                              ),
                              const Divider(height: 28),
                              _buildResultRow(
                                context,
                                'Tiempo',
                                _formatDuration(widget.duration),
                                Icons.timer,
                                AppTheme.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 24),
                    if (gamification != null) ...[
                      Text(
                        '🎁 Recompensas',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildRewardCard(
                            context,
                            'Nivel',
                            '${gamification.currentLevel}',
                            Icons.star,
                            AppTheme.accentColor,
                            0,
                          ),
                          _buildRewardCard(
                            context,
                            'Experiencia',
                            '+${widget.score} XP',
                            Icons.trending_up,
                            AppTheme.primaryColor,
                            200,
                          ),
                          _buildRewardCard(
                            context,
                            'Monedas',
                            '+${(widget.score / 2).round()}',
                            Icons.monetization_on,
                            AppTheme.accentColor,
                            400,
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

  Widget _buildResultRow(BuildContext context, String label, String value, IconData icon, Color iconColor) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double animValue, child) {
        return Opacity(
          opacity: animValue,
          child: Transform.translate(
            offset: Offset((1 - animValue) * 50, 0),
            child: child,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, String label, String value, IconData icon, Color cardColor, int delay) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        );
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cardColor.withOpacity(0.8),
              cardColor.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: cardColor, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w600,
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
