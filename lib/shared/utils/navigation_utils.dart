import 'package:flutter/material.dart';

Future<dynamic> goTo(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Future<dynamic> replacePage(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
