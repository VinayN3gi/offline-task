// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String hexColor;
  final String uid;
  final DateTime dueAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.hexColor,
    required this.uid,
    required this.dueAt,
    required this.createdAt,
    required this.updatedAt,
  });


  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? hexColor,
    String? uid,
    DateTime? dueAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hexColor: hexColor ?? this.hexColor,
      uid: uid ?? this.uid,
      dueAt: dueAt ?? this.dueAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'hexColor': hexColor,
      'uid': uid,
      'dueAt': dueAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      hexColor: map['hexColor'] ?? '',
      uid: map['uid'] ?? '',
      dueAt: DateTime.fromMillisecondsSinceEpoch(map['dueAt'] as int),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, hexColor: $hexColor, uid: $uid, dueAt: $dueAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.hexColor == hexColor &&
      other.uid == uid &&
      other.dueAt == dueAt &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      hexColor.hashCode ^
      uid.hashCode ^
      dueAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
