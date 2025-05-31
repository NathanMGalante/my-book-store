import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/validation_utils.dart';
import 'package:mybookstore/shared/widgets/custom_button.dart';
import 'package:mybookstore/shared/widgets/fields/custom_text_field.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  AuthController get controller => AuthController();

  final name = TextEditingController();
  final slogan = TextEditingController();

  bool _isValid = false;

  void _validate() {
    final isValidStoreName = requiredValidation(name.text) == null;
    final isValidSlogan = requiredValidation(slogan.text) == null;

    _isValid = isValidStoreName && isValidSlogan;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    name.addListener(_validate);
    slogan.addListener(_validate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 40.0,
                children: [
                  Text(
                    'Olá, ${AuthController().user!.name} 👋',
                    style: GoogleFonts.poppins(
                      fontSize: 32.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Image.asset(logoImage, height: 100),
                  Text(
                    'Cadastre sua loja',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      letterSpacing: 0.75,
                      color: bodyColor,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10.0,
                    children: [
                      CustomTextField(
                        label: 'Nome da loja',
                        controller: name,
                        validator: requiredValidation,
                      ),
                      CustomTextField(
                        label: 'Slogan da loja',
                        controller: slogan,
                        validator: requiredValidation,
                      ),
                    ],
                  ),
                  CustomButton(
                    text: 'Cadastrar',
                    loading: controller.isRegistering,
                    enabled: _isValid,
                    onTap:
                        () => controller.registerStore(
                          context: context,
                          name: name.text,
                          slogan: slogan.text,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
