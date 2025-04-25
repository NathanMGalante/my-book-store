import 'package:mybookstore/shared/models/book.dart';
import 'package:mybookstore/shared/utils/preference_utils.dart';

class BookmarkController {
  static final BookmarkController _instance = BookmarkController._internal();

  factory BookmarkController() => _instance;

  BookmarkController._internal();

  List<Book> get savedBooks {
    List<String>? books = PreferenceUtils.instance.getStringList('savedBooks');
    books ??= [];
    return books.map((e) => Book.fromJson(e)).toList();
  }

  Future<void> saveBook(Book book) async {
    final books = List.of(savedBooks);
    if (books.contains(book)) {
      books.remove(book);
    } else {
      books.add(book);
    }
    final encodedBooks = books.map((e) => e.toJson()).toList();
    await PreferenceUtils.instance.setStringList('savedBooks', encodedBooks);
  }
}
