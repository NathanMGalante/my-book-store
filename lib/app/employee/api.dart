import 'package:dio/dio.dart';
import 'package:mybookstore/shared/env.dart';
import 'package:mybookstore/shared/rest_client.dart';

class EmployeeApi {
  Future<Response> getEmployees(int storeId) async {
    return RestClient.private.get('${Env.store}/$storeId/employees');
  }
}
