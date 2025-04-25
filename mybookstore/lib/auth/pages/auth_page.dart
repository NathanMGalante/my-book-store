import 'package:flutter/material.dart';
import 'package:mybookstore/auth/controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthController().validateToken(context),
        builder: (context, snapshot) {
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
