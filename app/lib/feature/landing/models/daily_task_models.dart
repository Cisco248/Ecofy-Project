class DailyTaskModel {
  final String id;
  final String title;
  final String description;
  final String priority; // high, medium, low
  final String status; // pending, in_progress, completed
  final DateTime dueDate;
  final String? assignedTo;
  final DateTime createdAt;

  DailyTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    this.assignedTo,
    required this.createdAt,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) {
    return DailyTaskModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? 'medium',
      status: json['status'] ?? 'pending',
      dueDate: DateTime.parse(json['due_date']),
      assignedTo: json['assigned_to'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'due_date': dueDate.toIso8601String(),
      'assigned_to': assignedTo,
      'created_at': createdAt.toIso8601String(),
    };
  }

  DailyTaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? status,
    DateTime? dueDate,
    String? assignedTo,
    DateTime? createdAt,
  }) {
    return DailyTaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
