import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mybookstore/auth/api.dart';
import 'package:mybookstore/auth/models/auth.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/auth/pages/login-page.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/file_utils.dart';
import 'package:mybookstore/shared/utils/global_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';
import 'package:mybookstore/shared/utils/preference_utils.dart';
import 'package:mybookstore/shared/utils/role_utils.dart';
import 'package:mybookstore/shared/utils/snackbar_utils.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal(AuthApi());

  factory AuthController() => _instance;

  AuthController._internal(this._api);

  final AuthApi _api;

  Auth? get auth {
    final savedAuth = PreferenceUtils.instance.getString('auth');
    if (savedAuth == null) return null;
    return Auth.fromJson(savedAuth);
  }

  set auth(Auth? value) {
    if (value == null) {
      PreferenceUtils.instance.remove('auth');
    } else {
      PreferenceUtils.instance.setString('auth', value.toJson());
    }
  }

  User? get user => auth?.user;

  String? get token => auth?.accessToken;

  List<String> _getAuthorities() {
    if (token == null) return [];
    final decodedToken = JwtDecoder.decode(token!);
    return decodedToken['authorities'];
  }

  bool hasAuthority(Role role) {
    return _getAuthorities().contains(role.value);
  }

  bool hasAnyAuthority(List<Role> roles) {
    final authorities = _getAuthorities();
    return roles.any((role) => authorities.contains(role.value));
  }

  Observer<bool> isRegistering = false.obs();
  Observer<bool> isLogging = false.obs();

  Future<void> login({
    required BuildContext context,
    required String userName,
    required String password,
  }) async {
    try {
      isLogging.value = true;
      final payload = {'username': userName, 'password': password};
      final response = await _api.login(payload);
      auth = Auth.fromJson(response.data);
      nextTick(() => _redirect(context));
    } on DioException catch (ex) {
      context.showSnackBar(
        ex.response?.data == null || ex.response!.data!.toString().isEmpty
            ? 'Falha ao logar'
            : ex.response?.data,
        isError: true,
      );
      rethrow;
    } finally {
      isLogging.value = false;
    }
  }

  Future<void> _redirect(BuildContext context) {
    return NavigationController.of(context).goToHome(context);
  }

  Future<void> validateToken(context) async {
    if (token == null) {
      logout(context, inTheNextTick: true);
    } else if (JwtDecoder.isExpired(token!)) {
      try {
        await refreshToken();
        nextTick(() => _redirect(context));
      } catch (ex) {
        nextTick(() => replacePage(context, LoginPage()));
        rethrow;
      }
    } else {
      nextTick(() => _redirect(context));
    }
  }

  Future<String> refreshToken() async {
    final payload = {'refreshToken': auth!.refreshToken};
    final response = await _api.refreshToken(payload);
    final data = jsonDecode(response.data);
    auth = auth!.copyWith(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );
    return token!;
  }

  void logout(context, {bool inTheNextTick = false}) {
    auth = null;
    if (inTheNextTick) {
      nextTick(() => replacePage(context, LoginPage()));
    } else {
      replacePage(context, LoginPage());
    }
  }

  Future<void> register({
    required BuildContext context,
    required String storeName,
    required String sloganName,
    required String adminName,
    required String email,
    required String password,
    required File banner,
    required File adminImage,
  }) async {
    try {
      isRegistering.value = true;
      await _api.register({
        'name': storeName,
        'slogan': sloganName,
        'banner': await banner.base64,
        'admin': {
          'name': adminName,
          'photo': await adminImage.base64,
          'username': email,
          'password': password,
        },
      });
      context.showSnackBar('Loja registrada com sucesso');
      Navigator.pop(context);
    } on DioException catch (ex) {
      context.showSnackBar(
        ex.response?.data ?? 'Falha ao registrar loja',
        isError: true,
      );
      rethrow;
    } finally {
      isRegistering.value = false;
    }
  }
}
