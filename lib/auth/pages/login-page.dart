import 'package:flutter/material.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/pages/signup-page.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';
import 'package:mybookstore/shared/utils/validation_utils.dart';
import 'package:mybookstore/shared/widgets/custom_button.dart';
import 'package:mybookstore/shared/widgets/fields/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController get controller => AuthController();
  final userName = TextEditingController();
  final password = TextEditingController();

  bool _isValid = false;

  void _validate() {
    setState(() {
      _isValid =
          requiredValidation(userName.text) == null &&
          requiredValidation(password.text) == null;
    });
  }

  @override
  void initState() {
    userName.addListener(_validate);
    password.addListener(_validate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 40.0,
              children: [
                Image.asset(logoImage, height: 100),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10.0,
                  children: [
                    CustomTextField(
                      label: 'E-mail',
                      controller: userName,
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'Senha',
                      controller: password,
                      inputType: TextInputType.visiblePassword,
                      validator: requiredValidation,
                    ),
                  ],
                ),
                CustomButton(
                  onTap: () {
                    controller.login(
                      context: context,
                      userName: userName.text,
                      password: password.text,
                    );
                  },
                  text: 'Entrar',
                ),
                InkWell(
                  onTap: () => goTo(context, SignupPage()),
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
