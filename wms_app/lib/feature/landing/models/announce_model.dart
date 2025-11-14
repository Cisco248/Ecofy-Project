// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
      'dueDate': dueDate,
      'createdAt': createdAt,
    };
  }

  factory AnnounceModel.fromMap(Map<String, dynamic> map) {
    return AnnounceModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnounceModel.fromJson(String source) =>
      AnnounceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnnounceModel(id: $id, title: $title, description: $description, dueDate: $dueDate, createdAt: $createdAt)';
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
