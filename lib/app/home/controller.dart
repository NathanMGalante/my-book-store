import 'dart:convert';

import 'package:mybookstore/app/home/api.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/shared/models/book.dart';

class HomeController {
  static final HomeController _instance = HomeController._internal(HomeApi());

  factory HomeController() => _instance;

  HomeController._internal(this._api);

  final HomeApi _api;

  Store? get store => AuthController().auth?.store;

  List<Book> allBooks = [];

  Future<List<Book>> loadAllBooks() async {
    if (store == null) return [];
    final response = await _api.getAllBooks(store!.id);
    final books = jsonDecode(response.data) as List;
    allBooks = books.map((book) => Book.fromMap(book)).toList();
    return allBooks;
  }
}
