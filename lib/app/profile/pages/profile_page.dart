import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/app/bookmark/controller.dart';
import 'package:mybookstore/app/bookmark/pages/book_info_page.dart';
import 'package:mybookstore/app/home/widgets/book_card.dart';
import 'package:mybookstore/app/profile/pages/profile_edit_page.dart';
import 'package:mybookstore/app/profile/widgets/profile_avatar.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/shared/models/book.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  BookmarkController get controller => BookmarkController();

  List<Book> get savedBooks => controller.savedBooks;

  User get _user => AuthController().auth!.user;

  Store get _store => AuthController().auth!.store!;

  @override
  Widget build(BuildContext context) {
    debugPrint('ProfilePage');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileAvatar(user: _user),
            Text(
              _user.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _store.name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                  letterSpacing: 0.75,
                  color: bodySmallColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '\"${_store.slogan}\"',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  letterSpacing: 0.75,
                  color: bodySmallColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: InkWell(
                onTap: () async {
                  await goTo(context, ProfileEditPage());
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: lineColor, width: 2.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8.0,
                      children: [
                        Image.asset(
                          editIconImage,
                          color: primaryColor,
                          height: 24,
                        ),
                        Text(
                          'Editar',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Livros salvos',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                letterSpacing: 0.75,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Builder(
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
                  final width =
                      (MediaQuery.of(context).size.width - 48) / 2;
                  return Wrap(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
