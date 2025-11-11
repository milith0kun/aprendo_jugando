import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/activity.dart';
import '../../config/app_theme.dart';

class QuizActivityScreen extends StatefulWidget {
  final String activityId;

  const QuizActivityScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  State<QuizActivityScreen> createState() => _QuizActivityScreenState();
}

class _QuizActivityScreenState extends State<QuizActivityScreen> {
  Activity? _activity;
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _hintsUsed = 0;
  DateTime? _startTime;
  Map<int, String> _userAnswers = {};
  Map<int, bool> _answeredCorrectly = {};
  bool _isLoading = true;
  bool _showFeedback = false;
  bool? _lastAnswerCorrect;

  @override
  void initState() {
    super.initState();
    _loadActivity();
    _startTime = DateTime.now();
  }

  Future<void> _loadActivity() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final activity = await contentProvider.getActivityById(widget.activityId);

    if (activity != null && activity.type == 'quiz') {
      final content = QuizContent.fromJson(activity.content as Map<String, dynamic>);
      setState(() {
        _activity = activity;
        _questions = content.questions;
        _isLoading = false;
      });
    }
  }

  void _handleAnswer(String answer) {
    if (_showFeedback) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect = currentQuestion.isCorrect(answer);

    setState(() {
      _userAnswers[_currentQuestionIndex] = answer;
      _answeredCorrectly[_currentQuestionIndex] = isCorrect;
      _lastAnswerCorrect = isCorrect;
      _showFeedback = true;

      if (isCorrect) {
        _score += currentQuestion.points;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showFeedback = false;
        _lastAnswerCorrect = null;
      });
    } else {
      _completeActivity();
    }
  }

  void _useHint() {
    setState(() {
      _hintsUsed++;
    });

    final currentQuestion = _questions[_currentQuestionIndex];
    if (currentQuestion.hints.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.lightbulb, color: AppTheme.accentColor),
              SizedBox(width: 8),
              Text('Pista'),
            ],
          ),
          content: Text(currentQuestion.hints.first),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendido'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _completeActivity() async {
    final duration = DateTime.now().difference(_startTime!);
    final durationSeconds = duration.inSeconds;
    final scorePercentage = ((_score / _getTotalPoints()) * 100).round();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);

    await progressProvider.completeActivity(
      childId: authProvider.currentChild!.id,
      activityId: widget.activityId,
      score: scorePercentage,
      durationSeconds: durationSeconds,
      hintsUsed: _hintsUsed,
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      '/completion',
      arguments: {
        'score': scorePercentage,
        'totalQuestions': _questions.length,
        'correctAnswers':
            _answeredCorrectly.values.where((correct) => correct).length,
        'duration': durationSeconds,
        'activityTitle': _activity!.title,
      },
    );
  }

  int _getTotalPoints() {
    return _questions.fold(0, (sum, q) => sum + q.points);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_activity == null || _questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No se pudo cargar la actividad')),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Salir?'),
            content: const Text('Si sales ahora, perderás tu progreso.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Continuar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Salir'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_activity!.title),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (currentQuestion.hints.isNotEmpty && !_showFeedback)
                    OutlinedButton.icon(
                      onPressed: _useHint,
                      icon: const Icon(Icons.lightbulb_outline),
                      label: const Text('Pista'),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    currentQuestion.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ...currentQuestion.options.map((option) {
                final isSelected = _userAnswers[_currentQuestionIndex] == option;
                Color? buttonColor;

                if (_showFeedback && isSelected) {
                  buttonColor = _lastAnswerCorrect! ? AppTheme.secondaryColor : AppTheme.dangerColor;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: _showFeedback ? null : () => _handleAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        color: buttonColor != null ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
              if (_showFeedback) ...[
                const SizedBox(height: 24),
                Card(
                  color: _lastAnswerCorrect!
                      ? AppTheme.secondaryColor.withOpacity(0.1)
                      : AppTheme.dangerColor.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _lastAnswerCorrect! ? Icons.check_circle : Icons.cancel,
                              color: _lastAnswerCorrect!
                                  ? AppTheme.secondaryColor
                                  : AppTheme.dangerColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _lastAnswerCorrect! ? '¡Correcto!' : 'Incorrecto',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: _lastAnswerCorrect!
                                        ? AppTheme.secondaryColor
                                        : AppTheme.dangerColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentQuestion.explanation,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(
                    _currentQuestionIndex < _questions.length - 1
                        ? 'Siguiente Pregunta'
                        : 'Ver Resultados',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
