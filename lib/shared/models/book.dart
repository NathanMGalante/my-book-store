import 'dart:convert';

class Book {
  String author;
  bool available;
  String cover;
  int id;
  int idStore;
  int rating;
  String synopsis;
  String title;
  int year;

  Book({
    required this.author,
    required this.available,
    required this.cover,
    required this.id,
    required this.idStore,
    required this.rating,
    required this.synopsis,
    required this.title,
    required this.year,
  });

  Book clone() {
    return Book(
      author: author,
      available: available,
      cover: cover,
      id: id,
      idStore: idStore,
      rating: rating,
      synopsis: synopsis,
      title: title,
      year: year,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      author: map['author'],
      available: map['available'],
      cover: map['cover'],
      id: map['id'],
      idStore: map['idStore'],
      rating: map['rating'],
      synopsis: map['synopsis'],
      title: map['title'],
      year: map['year'],
    );
  }

  factory Book.fromJson(String json) {
    final map = jsonDecode(json);
    return Book(
      author: map['author'],
      available: map['available'],
      cover: map['cover'],
      id: map['id'],
      idStore: map['idStore'],
      rating: map['rating'],
      synopsis: map['synopsis'],
      title: map['title'],
      year: map['year'],
    );
  }

  String toJson() {
    return jsonEncode({
      'author': author,
      'available': available,
      'cover': cover,
      'id': id,
      'idStore': idStore,
      'rating': rating,
      'synopsis': synopsis,
      'title': title,
      'year': year,
    });
  }

  @override
  bool operator ==(Object other) => other is Book && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
