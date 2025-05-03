import 'dart:convert';

import 'package:mybookstore/auth/models/store.dart';
import 'package:mybookstore/auth/models/user.dart';

class Auth {
  String token;
  String refreshToken;
  final User user;
  final Store store;

  Auth({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.store,
  });

  Auth copyWith({
    String? token,
    String? refreshToken,
    User? user,
    Store? store,
  }) {
    return Auth(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      store: store ?? this.store,
    );
  }

  factory Auth.fromJson(String json) {
    final map = jsonDecode(json);
    return Auth(
      token: map['token'],
      refreshToken: map['refreshToken'],
      user: User.fromMap(map['user']),
      store: Store.fromMap(map['store']),
    );
  }

  String toJson() {
    return jsonEncode({
      'token': token,
      'refreshToken': refreshToken,
      'user': user.toMap(),
      'store': store.toMap(),
    });
  }
}
