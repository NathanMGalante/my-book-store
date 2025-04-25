import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/profile/controller.dart';
import 'package:mybookstore/profile/widgets/profile_avatar.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/validation_utils.dart';
import 'package:mybookstore/shared/widgets/app_bar_back_button.dart';
import 'package:mybookstore/shared/widgets/custom_button.dart';
import 'package:mybookstore/shared/widgets/fields/custom_text_field.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileController get controller => ProfileController();

  User get user => AuthController().auth!.user;

  Store get store => AuthController().auth!.store;

  late TextEditingController storeName;
  late TextEditingController sloganName;
  late TextEditingController adminName;
  late TextEditingController password;
  late TextEditingController repeatPassword;

  bool _isValid = false;

  void _validate() {
    final isValidStoreName = requiredValidation(storeName.text) == null;
    final isValidSlogan = requiredValidation(sloganName.text) == null;
    final isValidAdminName = requiredValidation(adminName.text) == null;
    final isValidPassword = passwordValidation(password.text) == null;
    final isValidRepeatPassword =
        repeatPasswordValidation(repeatPassword.text, password.text) == null;

    setState(() {
      _isValid =
          isValidStoreName &&
          isValidSlogan &&
          isValidAdminName &&
          isValidPassword &&
          isValidRepeatPassword;
    });
  }

  @override
  void initState() {
    storeName = TextEditingController(text: store.name);
    sloganName = TextEditingController(text: store.slogan);
    adminName = TextEditingController(text: user.name);
    password = TextEditingController();
    repeatPassword = TextEditingController();

    storeName.addListener(_validate);
    sloganName.addListener(_validate);
    adminName.addListener(_validate);
    password.addListener(_validate);
    repeatPassword.addListener(_validate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar perfil',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
            letterSpacing: 1,
            color: darkColor,
          ),
        ),
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
                ProfileAvatar(user: user),
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
                      label: 'Nome do usuário',
                      controller: adminName,
                      inputType: TextInputType.name,
                      validator: requiredValidation,
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
                  loading: controller.isEditing,
                  enabled: _isValid,
                  onTap:
                      () => controller.edit(
                        context: context,
                        storeName: storeName.text,
                        sloganName: sloganName.text,
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
