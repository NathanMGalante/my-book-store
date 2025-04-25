import 'package:flutter/material.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(64),
      child: Ink(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(64),
        ),
        child: Icon(Icons.chevron_left, color: Colors.white, size: 16),
      ),
    );
  }
}
