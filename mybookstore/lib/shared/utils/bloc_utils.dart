import 'package:flutter_bloc/flutter_bloc.dart';

class Observer<T> extends Cubit<T> {
  Observer(super.value);

  set value(T value) => emit(value);

  void refresh() => emit(state);

  T get value => state;
}
