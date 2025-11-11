class Topic {
  final String id;
  final String subjectId;
  final String name;
  final String description;
  final List<int> grades; // Applicable grades [1-6]
  final List<String> prerequisites; // Topic IDs that must be completed first
  final int estimatedMinutes;
  final int order;
  final String icon;

  Topic({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.grades,
    this.prerequisites = const [],
    required this.estimatedMinutes,
    required this.order,
    required this.icon,
  });

  bool isApplicableForGrade(int grade) {
    return grades.contains(grade);
  }

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      subjectId: json['subjectId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      grades: (json['grades'] as List<dynamic>).cast<int>(),
      prerequisites: (json['prerequisites'] as List<dynamic>?)?.cast<String>() ?? [],
      estimatedMinutes: json['estimatedMinutes'] as int,
      order: json['order'] as int,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'name': name,
      'description': description,
      'grades': grades,
      'prerequisites': prerequisites,
      'estimatedMinutes': estimatedMinutes,
      'order': order,
      'icon': icon,
    };
  }
}
