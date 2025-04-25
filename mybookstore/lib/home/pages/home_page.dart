import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/bookmark/controller.dart';
import 'package:mybookstore/bookmark/pages/book_info_page.dart';
import 'package:mybookstore/home/controller.dart';
import 'package:mybookstore/home/widgets/book_card.dart';
import 'package:mybookstore/shared/models/book.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  HomeController get controller => HomeController();

  BookmarkController get bookMarkController => BookmarkController();

  void _goToBookmarkPage(BuildContext context, List<Book> books, Book book) {
    showDialog(
      context: context,
      builder: (context) => BookInfoPage(bookList: books, initialBook: book),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Book>>(
          future: controller.loadAllBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final books = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(simpleLogoImage, width: 56),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Olá, ${AuthController().user!.name} 👋',
                        style: GoogleFonts.poppins(
                          fontSize: 32.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Livros salvos',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Builder(
                        builder: (context) {
                          if (bookMarkController.savedBooks.isEmpty) {
                            return Text(
                              'Nenhum livro salvo',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                letterSpacing: 0.75,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          final width =
                              (MediaQuery.of(context).size.width - 48) / 2;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 16.0,
                              children: [
                                for (final book
                                    in bookMarkController.savedBooks)
                                  SizedBox(
                                    width: width,
                                    child: InkWell(
                                      onTap: () {
                                        _goToBookmarkPage(context, books, book);
                                      },
                                      child: BookCard(book: book),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 32.0,
                      ),
                      child: Text(
                        'Todos os livros',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final books = snapshot.data ?? [];
                        if (books.isEmpty) {
                          return Text('Nenhum livro registrado');
                        }
                        final width =
                            (MediaQuery.of(context).size.width - 48) / 2;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: [
                              for (final book in books)
                                SizedBox(
                                  width: width,
                                  child: InkWell(
                                    onTap: () {
                                      _goToBookmarkPage(context, books, book);
                                    },
                                    child: BookCard(book: book),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
