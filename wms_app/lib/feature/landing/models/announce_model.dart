class AnnounceModel {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  String? createdAt;

  AnnounceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
  });

  AnnounceModel copyWith({
    String? id,
    String? title,
    String? description,
    String? dueDate,
    String? createdAt,
  }) {
    return AnnounceModel(
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

  factory AnnounceModel.fromMap(Map<String, dynamic> map) {
    return AnnounceModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: map['due_date'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  factory AnnounceModel.fromJson(json) {
    return AnnounceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['due_date'] ?? '',
      createdAt: json['created_at'] ?? '',
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

  @override
  String toString() {
    return 'AnnounceModel(id: $id, title: $title, description: $description, due_date: $dueDate, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant AnnounceModel other) {
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

class AnnounceResponse {
  final List<AnnounceModel> data;

  AnnounceResponse({required this.data});

  factory AnnounceResponse.fromJson(dynamic json) {
    var list = json as List;
    List<AnnounceModel> taskList = list
        .map((i) => AnnounceModel.fromJson(i))
        .toList();
    return AnnounceResponse(data: taskList);
  }
}
