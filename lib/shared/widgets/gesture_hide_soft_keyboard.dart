import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureHideSoftKeyboard extends StatelessWidget {
  const GestureHideSoftKeyboard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: child,
    );
  }
}
