import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mybookstore/app/profile/api.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/global_utils.dart';
import 'package:mybookstore/shared/utils/snackbar_utils.dart';

class ProfileController {
  static final ProfileController _instance = ProfileController._internal(
    ProfileApi(),
  );

  factory ProfileController() => _instance;

  ProfileController._internal(this._api);

  final ProfileApi _api;

  Observer<bool> isEditing = false.obs();

  Future<void> edit({
    required BuildContext context,
    required String storeName,
    required String sloganName,
  }) async {
    try {
      isEditing.value = true;
      Store store = AuthController().auth!.store!;
      await _api.edit(store.id, {
        'name': storeName,
        'slogan': sloganName,
      });
      store.name = storeName;
      store.slogan = sloganName;
      AuthController().auth = AuthController().auth!.copyWith(store: store);
      context.showSnackBar('Informações editadas com sucesso');
      Navigator.pop(context);
    } on DioException catch (ex) {
      context.showSnackBar(
        ex.response?.data ?? 'Falha ao Editar informações',
        isError: true,
      );
      rethrow;
    } finally {
      isEditing.value = false;
    }
  }
}
