import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required User user, this.radius = 40}) : _user = user;

  final User _user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      radius: radius,
      child: Container(
        decoration: BoxDecoration(
          image:
              _user.photo == null
                  ? null
                  : DecorationImage(
                    image: Image.memory(base64.decode(_user.photo!)).image,
                    fit: BoxFit.cover,
                  ),
        ),
        child: Text(
          _user.name.split(' ').map((e) => e[0].toUpperCase()).join(''),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            letterSpacing: 0.75,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
