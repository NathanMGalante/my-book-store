import 'package:flutter/material.dart';
import 'package:mybookstore/main_module.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/utils/preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.setBaseUrl('http://10.0.2.2:8080/');

  await PreferenceUtils.init();

  runApp(const MainModule(isHml: true));
}
