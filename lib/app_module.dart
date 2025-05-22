import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/pages/auth_page.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';
import 'package:mybookstore/shared/widgets/child_builder.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppModule extends StatelessWidget {
  const AppModule({super.key, this.isHml = false});

  final bool isHml;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBookStore',
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.copyWith(
            titleSmall: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: darkColor,
              letterSpacing: 0.75,
            ),
            bodySmall: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
              letterSpacing: 0.25,
              color: bodySmallColor,
            ),
          ),
        ),
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: darkColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
      ),
      builder: (context, page) {
        return ChildBuilder(
          builder: (context, child) {
            if (isHml) {
              return Banner(
                message: 'QA',
                location: BannerLocation.topStart,
                color: bannerColor,
                child: child,
              );
            }
            return child;
          },
          child: NavigationController(child: page ?? SizedBox.shrink()),
        );
      },
      home: const AuthPage(),
    );
  }
}
