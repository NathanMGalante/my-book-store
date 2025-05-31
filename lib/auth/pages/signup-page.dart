import 'package:flutter/material.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/validation_utils.dart';
import 'package:mybookstore/shared/widgets/app_bar_back_button.dart';
import 'package:mybookstore/shared/widgets/custom_button.dart';
import 'package:mybookstore/shared/widgets/fields/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthController get controller => AuthController();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  bool _isValid = false;

  void _validate() {
    final isValidAdminName = requiredValidation(name.text) == null;
    final isValidEmail = emailValidation(email.text) == null;
    final isValidPassword = passwordValidation(password.text) == null;
    final isValidRepeatPassword =
        repeatPasswordValidation(repeatPassword.text, password.text) == null;

    _isValid =
        isValidAdminName &&
        isValidEmail &&
        isValidPassword &&
        isValidRepeatPassword;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    name.addListener(_validate);
    email.addListener(_validate);
    password.addListener(_validate);
    repeatPassword.addListener(_validate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar loja'),
        titleSpacing: 0,
        leading: Center(child: AppBarBackButton()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                      label: 'Nome',
                      controller: name,
                      inputType: TextInputType.name,
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'E-mail',
                      controller: email,
                      inputType: TextInputType.name,
                      validator: emailValidation,
                    ),
                    CustomTextField(
                      label: 'Senha',
                      controller: password,
                      inputType: TextInputType.visiblePassword,
                      validator: passwordValidation,
                    ),
                    CustomTextField(
                      label: 'Repetir senha',
                      controller: repeatPassword,
                      inputType: TextInputType.visiblePassword,
                      validator: (value) {
                        return repeatPasswordValidation(
                          value,
                          password.value.text,
                        );
                      },
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Salvar',
                  loading: controller.isRegistering,
                  enabled: _isValid,
                  onTap:
                      () => controller.registerUser(
                        context: context,
                        name: name.text,
                        email: email.text,
                        password: password.text,
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
