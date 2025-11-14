class TaskModel {
  String? id;
  String? title;
  String? description;
  String? priority;
  String? status;
  String? dueDate;
  String? createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      dueDate: json['dueDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'due_date': dueDate,
      'created_at': createdAt,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? status,
    String? dueDate,
    String? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'dueDate': dueDate,
      'createdAt': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? '',
      status: map['status'] ?? '',
      dueDate: map['dueDate'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.status == status &&
        other.dueDate == dueDate &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        status.hashCode ^
        dueDate.hashCode ^
        createdAt.hashCode;
  }
}
