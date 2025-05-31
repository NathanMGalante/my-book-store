import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/app/bookmark/controller.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/models/book.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/date_time_utils.dart';
import 'package:mybookstore/shared/utils/global_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';
import 'package:mybookstore/shared/utils/role_utils.dart';
import 'package:mybookstore/shared/widgets/app_bar_back_button.dart';
import 'package:mybookstore/shared/widgets/custom_button.dart';

class BookInfoPage extends StatefulWidget {
  const BookInfoPage({
    super.key,
    required this.bookList,
    required this.initialBook,
  });

  final List<Book> bookList;
  final Book initialBook;

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
  BookmarkController get controller => BookmarkController();

  late Observer<Book> selectedBook;
  final FlutterCarouselController carouselController =
      FlutterCarouselController();

  @override
  void initState() {
    selectedBook = widget.initialBook.obs();
    super.initState();
  }

  Future<void> _saveBook(BuildContext context) async {
    await controller.saveBook(selectedBook.value);
    if (AuthController().hasAuthority(Role.admin)) {
      await NavigationController.of(context).goToHome(context);
    } else {
      await NavigationController.of(context).changePage(context, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('BookInfoPage');
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBarBackButton(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 64.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.0,
              children: [
                FlutterCarousel(
                  options: FlutterCarouselOptions(
                    height: 250,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.1,
                    padEnds: true,
                    initialPage: widget.bookList.indexOf(selectedBook.value),
                    showIndicator: false,
                    autoPlay: false,
                    controller: carouselController,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      selectedBook.value = widget.bookList[index];
                    },
                  ),
                  items: [
                    for (final book in widget.bookList)
                      GestureDetector(
                        onTap: () {
                          selectedBook.value = book;
                          carouselController.animateToPage(
                            widget.bookList.indexOf(book),
                          );
                        },
                        child: Image.asset(bookImage, fit: BoxFit.fitWidth),
                      ),
                  ],
                ),
                BlocBuilder<Observer<Book>, Book>(
                  bloc: selectedBook,
                  builder: (context, value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 24.0,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4.0,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                switchInCurve: Curves.easeInOut,
                                switchOutCurve: Curves.easeInOut,
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: Text(
                                  key: ValueKey<int>(selectedBook.value.id),
                                  selectedBook.value.title,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0,
                                    letterSpacing: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                switchInCurve: Curves.easeInOut,
                                switchOutCurve: Curves.easeInOut,
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: Text(
                                  selectedBook.value.author,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17.0,
                                    letterSpacing: 0.75,
                                    color: bodyColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4.0,
                            children: [
                              Text(
                                'Sinópse',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  letterSpacing: 0.75,
                                  color: darkColor,
                                ),
                              ),
                              Text(
                                selectedBook.value.synopsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.75,
                                  color: darkColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Publicado em',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  letterSpacing: 0.75,
                                  color: darkColor,
                                ),
                              ),
                              Text(
                                selectedBook
                                    .value
                                    .publicationDate
                                    .formattedDate,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.75,
                                  color: darkColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Avaliação',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    letterSpacing: 0.75,
                                    color: darkColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Icon(
                                        i <= selectedBook.value.rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: darkColor,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8.0,
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Switch(
                                    value: selectedBook.value.available,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBook.value.available = value;
                                      });
                                    },
                                  );
                                },
                              ),
                              Text(
                                'Estoque',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.75,
                                  color: darkColor,
                                ),
                              ),
                            ],
                          ),
                          CustomButton(
                            onTap: () => _saveBook(context),
                            text: 'Salvar',
                            icon: bookmarkIconImage,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
