import 'dart:convert';

import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';

class Auth {
  String accessToken;
  String refreshToken;
  final User user;
  final Store store;

  Auth({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.store,
  });

  Auth copyWith({
    String? accessToken,
    String? refreshToken,
    User? user,
    Store? store,
  }) {
    return Auth(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      store: store ?? this.store,
    );
  }

  factory Auth.fromJson(String json) {
    final map = jsonDecode(json);
    return Auth(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      user: User.fromMap(map['user']),
      store: Store.fromMap(map['store']),
    );
  }

  String toJson() {
    return jsonEncode({
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toMap(),
      'store': store.toMap(),
    });
  }
}
