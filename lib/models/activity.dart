class Activity {
  final String id;
  final String topicId;
  final String type; // 'quiz', 'puzzle', 'matching', 'sequence', 'reading'
  final String title;
  final String instructions;
  final int difficulty; // 1-5
  final int recommendedGrade;
  final int estimatedMinutes;
  final int points;
  final dynamic content; // Varies by type
  final List<String> imageUrls;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.topicId,
    required this.type,
    required this.title,
    required this.instructions,
    required this.difficulty,
    required this.recommendedGrade,
    required this.estimatedMinutes,
    required this.points,
    required this.content,
    this.imageUrls = const [],
    required this.createdAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      topicId: json['topicId'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      instructions: json['instructions'] as String,
      difficulty: json['difficulty'] as int,
      recommendedGrade: json['recommendedGrade'] as int,
      estimatedMinutes: json['estimatedMinutes'] as int,
      points: json['points'] as int,
      content: json['content'],
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'type': type,
      'title': title,
      'instructions': instructions,
      'difficulty': difficulty,
      'recommendedGrade': recommendedGrade,
      'estimatedMinutes': estimatedMinutes,
      'points': points,
      'content': content,
      'imageUrls': imageUrls,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

// Quiz specific models
class QuizContent {
  final List<QuizQuestion> questions;

  QuizContent({required this.questions});

  factory QuizContent.fromJson(Map<String, dynamic> json) {
    return QuizContent(
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class QuizQuestion {
  final String id;
  final String text;
  final String? imageUrl;
  final String type; // 'multiple_choice', 'true_false', 'text_input'
  final List<String> options;
  final dynamic correctAnswer; // Can be String, int, or bool
  final String explanation;
  final List<String> hints;
  final int points;

  QuizQuestion({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.hints = const [],
    required this.points,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'] as String,
      hints: (json['hints'] as List<dynamic>?)?.cast<String>() ?? [],
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'type': type,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'hints': hints,
      'points': points,
    };
  }

  bool isCorrect(dynamic answer) {
    if (type == 'multiple_choice') {
      return answer == correctAnswer;
    } else if (type == 'true_false') {
      return answer == correctAnswer;
    } else if (type == 'text_input') {
      return answer.toString().toLowerCase().trim() ==
          correctAnswer.toString().toLowerCase().trim();
    }
    return false;
  }
}
