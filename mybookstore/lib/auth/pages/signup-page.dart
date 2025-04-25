import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/file_utils.dart';
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

  final storeName = TextEditingController();
  final sloganName = TextEditingController();
  final bannerName = TextEditingController();
  final adminName = TextEditingController();
  final adminImageName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  File? banner;
  File? adminImage;

  bool _isValid = false;

  void _validate() {
    final isValidStoreName = requiredValidation(storeName.text) == null;
    final isValidSlogan = requiredValidation(sloganName.text) == null;
    final isValidBanner = requiredValidation(bannerName.text) == null;
    final isValidAdminName = requiredValidation(adminName.text) == null;
    final isValidAdminImage = requiredValidation(adminImageName.text) == null;
    final isValidEmail = emailValidation(email.text) == null;
    final isValidPassword = passwordValidation(password.text) == null;
    final isValidRepeatPassword =
        repeatPasswordValidation(repeatPassword.text, password.text) == null;

    setState(() {
      _isValid =
          isValidStoreName &&
          isValidSlogan &&
          isValidBanner &&
          isValidAdminName &&
          isValidAdminImage &&
          isValidEmail &&
          isValidPassword &&
          isValidRepeatPassword;
    });
  }

  @override
  void initState() {
    storeName.addListener(_validate);
    sloganName.addListener(_validate);
    bannerName.addListener(_validate);
    adminName.addListener(_validate);
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
                      label: 'Nome da loja',
                      controller: storeName,
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'Slogan da loja',
                      controller: sloganName,
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'Banner',
                      controller: bannerName,
                      readOnly: true,
                      onTap: () async {
                        final image = await getImage(context);
                        if (image != null) {
                          banner = image;
                          bannerName.text = image.name;
                        }
                      },
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'Nome do administrador',
                      controller: adminName,
                      inputType: TextInputType.name,
                      validator: requiredValidation,
                    ),
                    CustomTextField(
                      label: 'Foto do administrador',
                      controller: adminImageName,
                      readOnly: true,
                      onTap: () async {
                        final image = await getImage(context);
                        if (image != null) {
                          adminImage = image;
                          adminImageName.text = image.name;
                        }
                      },
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
                      () => controller.register(
                        context: context,
                        storeName: storeName.text,
                        sloganName: sloganName.text,
                        adminName: adminName.text,
                        email: email.text,
                        password: password.text,
                        banner: banner!,
                        adminImage: adminImage!,
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
