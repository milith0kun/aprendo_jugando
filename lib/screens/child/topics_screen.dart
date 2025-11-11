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

    return Scaffold(
      appBar: AppBar(
        title: Text(subject?.name ?? 'Temas'),
        backgroundColor: _getSubjectColor(subject?.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _topics.isEmpty
              ? const Center(child: Text('No hay temas disponibles'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _topics.length,
                  itemBuilder: (context, index) {
                    final topic = _topics[index];
                    return _buildTopicCard(context, topic);
                  },
                ),
    );
  }

  Widget _buildTopicCard(BuildContext context, dynamic topic) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/activities',
            arguments: {'topicId': topic.id},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getSubjectColor(null).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconData(topic.icon),
                  color: _getSubjectColor(null),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '~${topic.estimatedMinutes} min',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
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
        return Icons.add_circle;
      case 'close':
        return Icons.close;
      case 'pie_chart':
        return Icons.pie_chart;
      case 'edit':
        return Icons.edit;
      case 'auto_stories':
        return Icons.auto_stories;
      case 'spellcheck':
        return Icons.spellcheck;
      case 'calculator':
      case 'calculate':
        return Icons.calculate;
      case 'abc':
        return Icons.abc;
      default:
        return Icons.school;
    }
  }
}
