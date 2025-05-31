import 'dart:convert';

import 'package:mybookstore/app/employee/api.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';

class EmployeeController {
  static final EmployeeController _instance = EmployeeController._internal(
    EmployeeApi(),
  );

  factory EmployeeController() => _instance;

  EmployeeController._internal(this._api);

  final EmployeeApi _api;

  Store? get store => AuthController().auth?.store;

  Future<List<User>> loadEmployees() async {
    if (store == null) return [];
    final response = await _api.getEmployees(store!.id);
    final employees = jsonDecode(response.data) as List;
    return employees.map((book) => User.fromMap(book)).toList();
  }
}
