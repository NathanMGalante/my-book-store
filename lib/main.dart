import 'package:flutter/material.dart';
import 'package:mybookstore/app_module.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/utils/preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.setBaseUrl('https://api-flutter-prova.hml.sesisenai.org.br/');

  await PreferenceUtils.init();

  runApp(const AppModule());
}
