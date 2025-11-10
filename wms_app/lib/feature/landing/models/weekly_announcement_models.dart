class WeeklyAnnouncementModels {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime createdAt;

  WeeklyAnnouncementModels({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
  });

  factory WeeklyAnnouncementModels.fromJson(Map<String, dynamic> json) {
    return WeeklyAnnouncementModels(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: DateTime.parse(json['due_date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  WeeklyAnnouncementModels copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? createdAt,
  }) {
    return WeeklyAnnouncementModels(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
