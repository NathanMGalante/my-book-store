import 'package:flutter/material.dart';

class ChildBuilder extends StatelessWidget {
  const ChildBuilder({super.key, required this.builder, required this.child});

  final Widget child;
  final Widget Function(BuildContext, Widget) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
