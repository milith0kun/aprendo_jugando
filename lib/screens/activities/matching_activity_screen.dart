import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/activity.dart';
import '../../config/app_theme.dart';

class MatchingActivityScreen extends StatefulWidget {
  final String activityId;

  const MatchingActivityScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  State<MatchingActivityScreen> createState() => _MatchingActivityScreenState();
}

class _MatchingActivityScreenState extends State<MatchingActivityScreen>
    with TickerProviderStateMixin {
  Activity? _activity;
  List<MatchingItem> _leftItems = [];
  List<MatchingItem> _rightItems = [];
  Map<String, String> _userMatches = {};
  Set<String> _correctMatches = {};
  DateTime? _startTime;
  bool _isLoading = true;
  bool _isCheckingAnswers = false;
  String? _selectedLeftItem;

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _loadActivity();
    _startTime = DateTime.now();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _loadActivity() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final activity = await contentProvider.getActivityById(widget.activityId);

    if (activity != null && activity.type == 'matching') {
      final content = activity.content as Map<String, dynamic>;
      final pairs = (content['pairs'] as List).cast<Map<String, dynamic>>();

      setState(() {
        _activity = activity;
        _leftItems = pairs.map((p) {
          return MatchingItem(
            id: p['id'] as String,
            text: p['left'] as String,
            pairId: p['id'] as String,
          );
        }).toList()
          ..shuffle();

        _rightItems = pairs.map((p) {
          return MatchingItem(
            id: '${p['id']}_right',
            text: p['right'] as String,
            pairId: p['id'] as String,
          );
        }).toList()
          ..shuffle();

        _isLoading = false;
      });
    }
  }

  void _handleItemTap(String itemId, bool isLeft) {
    if (_isCheckingAnswers) return;

    if (isLeft) {
      setState(() {
        _selectedLeftItem = _selectedLeftItem == itemId ? null : itemId;
      });
    } else {
      if (_selectedLeftItem != null) {
        setState(() {
          _userMatches[_selectedLeftItem!] = itemId;
          _selectedLeftItem = null;
        });
      }
    }
  }

  void _checkAnswers() {
    setState(() {
      _isCheckingAnswers = true;
    });

    _correctMatches.clear();

    for (var entry in _userMatches.entries) {
      final leftItem = _leftItems.firstWhere((item) => item.id == entry.key);
      final rightItem = _rightItems.firstWhere((item) => item.id == entry.value);

      if (leftItem.pairId == rightItem.pairId) {
        _correctMatches.add(entry.key);
      }
    }

    if (_correctMatches.length == _leftItems.length) {
      // All correct!
      Future.delayed(const Duration(milliseconds: 500), () {
        _completeActivity();
      });
    } else {
      // Some incorrect
      _shakeController.forward().then((_) => _shakeController.reverse());
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isCheckingAnswers = false;
        });
      });
    }
  }

  Future<void> _completeActivity() async {
    final duration = DateTime.now().difference(_startTime!);
    final durationSeconds = duration.inSeconds;
    final scorePercentage = (_correctMatches.length / _leftItems.length * 100).round();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);

    await progressProvider.completeActivity(
      childId: authProvider.currentChild!.id,
      activityId: widget.activityId,
      score: scorePercentage,
      durationSeconds: durationSeconds,
      hintsUsed: 0,
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      '/completion',
      arguments: {
        'score': scorePercentage,
        'totalQuestions': _leftItems.length,
        'correctAnswers': _correctMatches.length,
        'duration': durationSeconds,
        'activityTitle': _activity!.title,
      },
    );
  }

  void _clearMatches() {
    setState(() {
      _userMatches.clear();
      _correctMatches.clear();
      _selectedLeftItem = null;
      _isCheckingAnswers = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No se pudo cargar la actividad')),
      );
    }

    final progress = _userMatches.length / _leftItems.length;

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
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
            ),
          ),
          title: Text(
            _activity!.title,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
              minHeight: 6,
            ),
          ),
        ),
        body: Column(
          children: [
            // Instructions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.secondaryColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.touch_app, size: 40, color: AppTheme.primaryColor),
                  const SizedBox(height: 8),
                  Text(
                    'Toca un elemento de la izquierda y luego su pareja de la derecha',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_userMatches.length} de ${_leftItems.length} emparejados',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Matching Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Left Column
                    Expanded(
                      child: ListView.builder(
                        itemCount: _leftItems.length,
                        itemBuilder: (context, index) {
                          return _buildLeftItem(_leftItems[index]);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Right Column
                    Expanded(
                      child: ListView.builder(
                        itemCount: _rightItems.length,
                        itemBuilder: (context, index) {
                          return _buildRightItem(_rightItems[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _userMatches.isEmpty ? null : _clearMatches,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reiniciar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _userMatches.length == _leftItems.length
                          ? _checkAnswers
                          : null,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Verificar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: AppTheme.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftItem(MatchingItem item) {
    final isSelected = _selectedLeftItem == item.id;
    final isMatched = _userMatches.containsKey(item.id);
    final isCorrect = _correctMatches.contains(item.id);
    final isIncorrect = _isCheckingAnswers && isMatched && !isCorrect;

    Color borderColor;
    Color backgroundColor;

    if (isCorrect) {
      borderColor = AppTheme.secondaryColor;
      backgroundColor = AppTheme.secondaryColor.withOpacity(0.2);
    } else if (isIncorrect) {
      borderColor = AppTheme.dangerColor;
      backgroundColor = AppTheme.dangerColor.withOpacity(0.2);
    } else if (isSelected) {
      borderColor = AppTheme.primaryColor;
      backgroundColor = AppTheme.primaryColor.withOpacity(0.2);
    } else if (isMatched) {
      borderColor = AppTheme.accentColor;
      backgroundColor = AppTheme.accentColor.withOpacity(0.1);
    } else {
      borderColor = Colors.grey[300]!;
      backgroundColor = Colors.white;
    }

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset = isIncorrect
            ? Math.sin(_shakeController.value * Math.pi * 2) * 10
            : 0.0;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isCorrect ? null : () => _handleItemTap(item.id, true),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 2),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  if (isCorrect)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.check_circle, color: AppTheme.secondaryColor),
                    ),
                  if (isIncorrect)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.cancel, color: AppTheme.dangerColor),
                    ),
                  Expanded(
                    child: Text(
                      item.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected || isMatched ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightItem(MatchingItem item) {
    final isMatched = _userMatches.values.contains(item.id);
    final matchingLeftId = _userMatches.entries
        .firstWhere(
          (entry) => entry.value == item.id,
          orElse: () => MapEntry('', ''),
        )
        .key;
    final isCorrect = _correctMatches.contains(matchingLeftId);
    final isIncorrect = _isCheckingAnswers && isMatched && !isCorrect;

    Color borderColor;
    Color backgroundColor;

    if (isCorrect) {
      borderColor = AppTheme.secondaryColor;
      backgroundColor = AppTheme.secondaryColor.withOpacity(0.2);
    } else if (isIncorrect) {
      borderColor = AppTheme.dangerColor;
      backgroundColor = AppTheme.dangerColor.withOpacity(0.2);
    } else if (isMatched) {
      borderColor = AppTheme.accentColor;
      backgroundColor = AppTheme.accentColor.withOpacity(0.1);
    } else {
      borderColor = Colors.grey[300]!;
      backgroundColor = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isCorrect || _selectedLeftItem == null
              ? null
              : () => _handleItemTap(item.id, false),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Row(
              children: [
                if (isCorrect)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.check_circle, color: AppTheme.secondaryColor),
                  ),
                if (isIncorrect)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.cancel, color: AppTheme.dangerColor),
                  ),
                Expanded(
                  child: Text(
                    item.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isMatched ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MatchingItem {
  final String id;
  final String text;
  final String pairId;

  MatchingItem({
    required this.id,
    required this.text,
    required this.pairId,
  });
}
