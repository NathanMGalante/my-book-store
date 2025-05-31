import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/app/bookmark/controller.dart';
import 'package:mybookstore/app/bookmark/pages/book_info_page.dart';
import 'package:mybookstore/app/home/widgets/book_card.dart';
import 'package:mybookstore/shared/models/book.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  BookmarkController get controller => BookmarkController();

  List<Book> get savedBooks => controller.savedBooks;

  @override
  Widget build(BuildContext context) {
    debugPrint('BookMarkPage');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              'Livros salvos',
              style: GoogleFonts.poppins(
                fontSize: 32.0,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if (savedBooks.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhum livro salvo',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              final width = (MediaQuery.of(context).size.width - 48) / 2;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    for (final book in savedBooks)
                      SizedBox(
                        width: width,
                        child: InkWell(
                          onTap: () {
                            goTo(
                              context,
                              BookInfoPage(
                                bookList: savedBooks,
                                initialBook: book,
                              ),
                            );
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
    );
  }
}
