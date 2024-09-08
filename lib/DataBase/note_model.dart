// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final int? id;
  final String? title;
  final String? content;
  final bool? isFavourite;
  final String? dateTime;
  static const String tableName = "Notes";
  static const String colId = "id";
  static const String colTitle = "title";
  static const String colContent = "content";
  static const String colIsFavourite = 'isFavourite';
  static const String colDateTime = "dateTime";
  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT NOT NULL, $colContent TEXT NOT NULL,$colIsFavourite INTEGER ,$colDateTime TEXT NOT NULL)";

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.isFavourite,
    this.dateTime,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    bool? isFavourite,
    String? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavourite: isFavourite ?? this.isFavourite,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'isFavourite': isFavourite,
      'dateTime': dateTime,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      isFavourite: map['isFavourite'] != null ? map['isFavourite'] == 1 : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: $content, isFavourite: $isFavourite, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.isFavourite == isFavourite &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        isFavourite.hashCode ^
        dateTime.hashCode;
  }
}
