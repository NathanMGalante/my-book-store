import 'package:dio/dio.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/rest_client.dart';

class ProfileApi {
  Future<Response> edit(int storeId, Map<String, dynamic> data) async {
    return RestClient.private.put('${Env.store}/$storeId', data: data);
  }
}
