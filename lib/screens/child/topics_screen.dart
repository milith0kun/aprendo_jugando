import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/content_provider.dart';
import '../../providers/progress_provider.dart';
import '../../config/app_theme.dart';

class TopicsScreen extends StatefulWidget {
  final String subjectId;

  const TopicsScreen({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  List<dynamic> _topics = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final topics = await contentProvider.getTopics(
      widget.subjectId,
      grade: authProvider.currentChild?.grade,
    );

    setState(() {
      _topics = topics;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final subject = contentProvider.getSubjectById(widget.subjectId);
    final subjectColor = _getSubjectColor(subject?.name);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          subject?.name ?? 'Temas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppTheme.borderColor,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _topics.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 80,
                        color: AppTheme.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay temas disponibles',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _topics.length,
                  itemBuilder: (context, index) {
                    final topic = _topics[index];
                    return _buildMinimalistTopicCard(context, topic, index);
                  },
                ),
    );
  }

  Widget _buildMinimalistTopicCard(BuildContext context, dynamic topic, int index) {
    // Colores específicos por tema (versión minimalista)
    final topicColors = {
      'topic1': AppTheme.mathColor, // Suma y Resta
      'topic2': AppTheme.spellingColor, // Multiplicación
      'topic2b': AppTheme.divisionColor, // División
      'topic3': AppTheme.fractionColor, // Fracciones
      'topic4': AppTheme.languageColor, // Lectoescritura
      'topic5': AppTheme.successColor, // Comprensión
      'topic6': AppTheme.spellingColor, // Ortografía
      'topic7': AppTheme.grammarColor, // Gramática
    };

    final cardColor = topicColors[topic.id] ?? _getSubjectColor(null);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/activities',
              arguments: {'topicId': topic.id},
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Ícono minimalista
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconData(topic.icon),
                    color: cardColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),

                // Información del tema
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        topic.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Badge de tiempo
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '~${topic.estimatedMinutes} min',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Flecha
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppTheme.textTertiary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getSubjectColor(String? subjectName) {
    if (subjectName == 'Matemáticas' ||
        widget.subjectId == 'subject1') {
      return AppTheme.mathColor;
    } else if (subjectName == 'Lengua' ||
        widget.subjectId == 'subject2') {
      return AppTheme.languageColor;
    }
    return AppTheme.primaryColor;
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'add_circle':
        return Icons.add_circle_rounded;
      case 'close':
        return Icons.close_rounded;
      case 'pie_chart':
        return Icons.pie_chart_rounded;
      case 'edit':
        return Icons.edit_rounded;
      case 'auto_stories':
        return Icons.auto_stories_rounded;
      case 'spellcheck':
        return Icons.spellcheck_rounded;
      case 'calculator':
      case 'calculate':
        return Icons.calculate_rounded;
      case 'abc':
        return Icons.abc_rounded;
      default:
        return Icons.school_rounded;
    }
  }
}
