import 'dart:convert';

class Book {
  int id;
  DateTime creationDateTime;
  String title;
  String synopsis;
  String author;
  DateTime publicationDate;
  bool available;
  int rating;
  String? cover;

  Book({
    required this.id,
    required this.creationDateTime,
    required this.title,
    required this.synopsis,
    required this.author,
    required this.publicationDate,
    required this.available,
    required this.rating,
    required this.cover,
  });

  Book clone() {
    return Book(
      id: id,
      creationDateTime: creationDateTime,
      title: title,
      synopsis: synopsis,
      author: author,
      publicationDate: publicationDate,
      available: available,
      rating: rating,
      cover: cover,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      creationDateTime: DateTime.parse(map['creationDateTime']),
      title: map['title'],
      synopsis: map['synopsis'],
      author: map['author'],
      publicationDate: DateTime.parse(map['publicationDate']),
      available: map['available'],
      rating: map['rating'],
      cover: map['cover'],
    );
  }

  factory Book.fromJson(String json) {
    return Book.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'creationDateTime': creationDateTime.toIso8601String(),
      'title': title,
      'synopsis': synopsis,
      'author': author,
      'publicationDate': publicationDate.toIso8601String(),
      'available': available,
      'rating': rating,
      'cover': cover,
    });
  }

  @override
  bool operator ==(Object other) => other is Book && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
