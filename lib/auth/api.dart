import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/rest_client.dart';

class AuthApi {
  Future<Response> register(Map<String, dynamic> data) async {
    return RestClient.public.post(Env.store, data: data);
  }
  Future<Response> login(Map<String, dynamic> data) async {
    return RestClient.public.post(Env.login, data: data);
  }
  Future<Response> refreshToken(Map<String, dynamic> data) async {
    debugPrint('refreshToken data: $data');
    return RestClient.public.post(Env.refreshToken, data: data);
  }
}
