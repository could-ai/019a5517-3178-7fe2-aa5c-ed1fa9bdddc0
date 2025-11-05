class Task {
  final String id;
  final String title;
  final String description;
  final double reward;
  final String category;
  final String difficulty;
  final String timeEstimate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.reward,
    required this.category,
    required this.difficulty,
    required this.timeEstimate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reward': reward,
      'category': category,
      'difficulty': difficulty,
      'timeEstimate': timeEstimate,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      reward: (json['reward'] as num).toDouble(),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      timeEstimate: json['timeEstimate'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}