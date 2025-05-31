import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/app/profile/controller.dart';
import 'package:mybookstore/app/profile/widgets/profile_avatar.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
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

  Store get store => AuthController().auth!.store!;

  late TextEditingController storeName;
  late TextEditingController sloganName;

  bool _isValid = false;

  void _validate() {
    _isValid =
        requiredValidation(storeName.text) == null &&
        requiredValidation(sloganName.text) == null;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    storeName = TextEditingController(text: store.name);
    sloganName = TextEditingController(text: store.slogan);
    storeName.addListener(_validate);
    sloganName.addListener(_validate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ProfileEditPage');
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
