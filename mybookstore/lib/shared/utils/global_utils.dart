import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';

extension GenericExtension<T> on T {
  Observer<T> obs() => Observer(this);
}

void nextTick(VoidCallback action) {
  WidgetsBinding.instance.addPostFrameCallback((_) => action());
}