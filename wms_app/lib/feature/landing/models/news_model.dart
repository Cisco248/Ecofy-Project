// ignore_for_file: strict_top_level_inference

class NewsModel {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  String? createdAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
  });

  NewsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? dueDate,
    String? createdAt,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'created_at': createdAt,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: map['due_date'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'created_at': createdAt,
    };
  }

  factory NewsModel.fromJson(json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['due_date'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, due_date: $dueDate, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.dueDate == dueDate &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        createdAt.hashCode;
  }
}

class NewsResponse {
  final List<NewsModel> data;

  NewsResponse({required this.data});

  factory NewsResponse.fromJson(dynamic json) {
    var list = json as List;
    List<NewsModel> taskList = list.map((i) => NewsModel.fromJson(i)).toList();
    return NewsResponse(data: taskList);
  }
}
