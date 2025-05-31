import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mybookstore/app/home/pages/guest_home_page.dart';
import 'package:mybookstore/auth/api.dart';
import 'package:mybookstore/auth/models/auth.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/auth/pages/login-page.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/global_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';
import 'package:mybookstore/shared/utils/preference_utils.dart';
import 'package:mybookstore/shared/utils/role_utils.dart';
import 'package:mybookstore/shared/utils/snackbar_utils.dart';
import 'package:mybookstore/shared/widgets/navigation_wrapper.dart';

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
    return (decodedToken['authorities'] as List).whereType<String>().toList();
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
    if (hasAuthority(Role.user)) {
      return replacePage(context, GuestHomePage());
    }
    return replacePage(context, NavigationWrapper());
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

  Completer<String>? refreshCompleter;

  Future<String> refreshToken() async {
    try {
      if (refreshCompleter != null && !refreshCompleter!.isCompleted) {
        return refreshCompleter!.future;
      }
      refreshCompleter = Completer();
      final payload = {'refreshToken': auth!.refreshToken};
      debugPrint('payload');
      final response = await _api.refreshToken(payload);
      debugPrint('response');
      final data = jsonDecode(response.data);
      auth = auth!.copyWith(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );
      refreshCompleter!.complete(token!);
      refreshCompleter = null;
      return token!;
    } catch (ex) {
      debugPrint('refresh ex: $ex');
      rethrow;
    }
  }

  void logout(context, {bool inTheNextTick = false}) {
    auth = null;
    if (inTheNextTick) {
      nextTick(() => replacePage(context, LoginPage()));
    } else {
      replacePage(context, LoginPage());
    }
  }

  Future<void> registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isRegistering.value = true;
      await _api.registerUser({'name': name, 'email': email, 'password': password});
      context.showSnackBar('Usuário registrado com sucesso');
      Navigator.pop(context);
    } on DioException catch (ex) {
      context.showSnackBar(
        ex.response?.data ?? 'Falha ao registrar usuário',
        isError: true,
      );
      rethrow;
    } finally {
      isRegistering.value = false;
    }
  }

  Future<void> registerStore({
    required BuildContext context,
    required String name,
    required String slogan,
  }) async {
    try {
      isRegistering.value = true;
      await _api.registerStore({'name': name, 'slogan': slogan});
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
