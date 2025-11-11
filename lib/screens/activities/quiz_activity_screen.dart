import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/activity.dart';
import '../../config/app_theme.dart';
import '../../widgets/animated_feedback_card.dart';
import '../../widgets/educational_button.dart';
import '../../widgets/animated_progress_bar.dart';

class QuizActivityScreen extends StatefulWidget {
  final String activityId;

  const QuizActivityScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  State<QuizActivityScreen> createState() => _QuizActivityScreenState();
}

class _QuizActivityScreenState extends State<QuizActivityScreen>
    with TickerProviderStateMixin {
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
  String? _readingText; // Texto de lectura para comprensión lectora

  late AnimationController _questionController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadActivity();
    _startTime = DateTime.now();

    // Animación para transición de preguntas
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _loadActivity() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final activity = await contentProvider.getActivityById(widget.activityId);

    if (activity != null && activity.type == 'quiz') {
      final content = QuizContent.fromJson(activity.content as Map<String, dynamic>);

      // Filtrar preguntas que no son de tipo text_display
      // Las preguntas text_display se usan para mostrar texto de lectura
      final actualQuestions = content.questions
          .where((q) => q.type != 'text_display')
          .toList();

      // Si hay preguntas text_display, usar su texto, sino usar el campo text del content
      final textDisplayQuestion = content.questions
          .firstWhere((q) => q.type == 'text_display',
              orElse: () => content.questions.first);

      setState(() {
        _activity = activity;
        _questions = actualQuestions;
        _readingText = content.text ??
            (textDisplayQuestion.type == 'text_display' ? textDisplayQuestion.text : null);
        _isLoading = false;
      });
      _questionController.forward();
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

    // Vibración ligera para feedback háptico
    // HapticFeedback.lightImpact(); // Descomentardescomenta si deseas agregar vibración
  }

  void _nextQuestion() async {
    if (_currentQuestionIndex < _questions.length - 1) {
      // Animar salida de pregunta actual
      await _questionController.reverse();

      setState(() {
        _currentQuestionIndex++;
        _showFeedback = false;
        _lastAnswerCorrect = null;
      });

      // Animar entrada de nueva pregunta
      _questionController.forward();
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(width: 12),
              const Text('💡 Pista'),
            ],
          ),
          content: Text(
            currentQuestion.hints.first,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Entendido',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Cargando actividad...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    if (_activity == null || _questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppTheme.dangerColor),
              SizedBox(height: 16),
              Text('No se pudo cargar la actividad'),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.warning_rounded, color: AppTheme.dangerColor),
                SizedBox(width: 12),
                Text('¿Salir?'),
              ],
            ),
            content: const Text('Si sales ahora, perderás tu progreso en esta actividad.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Continuar actividad'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.dangerColor,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Salir'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.cardBackground,
          title: Text(_activity!.title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.rewardColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        size: 18,
                        color: AppTheme.rewardColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$_score pts',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.rewardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: AnimatedProgressBar(
                progress: progress,
                color: AppTheme.successColor,
                height: 6,
              ),
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header con contador y pista
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      if (currentQuestion.hints.isNotEmpty && !_showFeedback)
                        OutlinedButton.icon(
                          onPressed: _useHint,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.accentColor.withOpacity(0.5),
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          icon: const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: AppTheme.accentColor,
                          ),
                          label: const Text(
                            'Pista',
                            style: TextStyle(color: AppTheme.accentColor),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Texto de lectura (si existe)
                  if (_readingText != null) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  color: AppTheme.primaryColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                '📖 Lee con atención',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _readingText!,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: AppTheme.textPrimary,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Pregunta
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.help_outline_rounded,
                          size: 40,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentQuestion.text,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Opciones de respuesta
                  ...currentQuestion.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = _userAnswers[_currentQuestionIndex] == option;
                    final isCorrectAnswer = _showFeedback && isSelected && _lastAnswerCorrect == true;
                    final isIncorrectAnswer = _showFeedback && isSelected && _lastAnswerCorrect == false;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: EducationalButton(
                        text: option,
                        onPressed: _showFeedback ? null : () => _handleAnswer(option),
                        isSelected: isSelected,
                        isCorrect: isCorrectAnswer,
                        isIncorrect: isIncorrectAnswer,
                        showFeedback: _showFeedback,
                        icon: Icons.radio_button_unchecked_rounded,
                      ),
                    );
                  }).toList(),

                  // Feedback
                  if (_showFeedback && _lastAnswerCorrect != null) ...[
                    const SizedBox(height: 8),
                    AnimatedFeedbackCard(
                      isCorrect: _lastAnswerCorrect!,
                      explanation: currentQuestion.explanation,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: _lastAnswerCorrect!
                              ? AppTheme.successColor
                              : AppTheme.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentQuestionIndex < _questions.length - 1
                                  ? 'Siguiente Pregunta'
                                  : 'Ver Resultados',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              _currentQuestionIndex < _questions.length - 1
                                  ? Icons.arrow_forward_rounded
                                  : Icons.emoji_events_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
