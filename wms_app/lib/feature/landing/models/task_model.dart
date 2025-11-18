// ignore_for_file: strict_top_level_inference

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
      'due_date': dueDate,
      'created_at': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? '',
      status: map['status'] ?? '',
      dueDate: map['due_date'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  factory TaskModel.fromJson(json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      dueDate: json['due_date'] ?? '',
      createdAt: json['created_at'] ?? '',
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

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, due_date: $dueDate, created_at: $createdAt)';
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

class TaskResponse {
  final List<TaskModel> data;

  TaskResponse({required this.data});

  factory TaskResponse.fromJson(dynamic json) {
    var list = json as List;
    List<TaskModel> taskList = list.map((i) => TaskModel.fromJson(i)).toList();
    return TaskResponse(data: taskList);
  }
}
