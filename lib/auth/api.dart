import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/rest_client.dart';

class AuthApi {
  Future<Response> registerUser(Map<String, dynamic> data) async {
    return RestClient.public.post(Env.register, data: data);
  }
  Future<Response> login(Map<String, dynamic> data) async {
    return RestClient.public.post(Env.login, data: data);
  }
  Future<Response> refreshToken(Map<String, dynamic> data) async {
    return RestClient.public.post(Env.refreshToken, data: data);
  }
  Future<Response> registerStore(Map<String, dynamic> data) async {
    return RestClient.private.post(Env.registerStore, data: data);
  }
}
