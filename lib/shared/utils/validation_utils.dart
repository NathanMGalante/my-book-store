String? requiredValidation(dynamic value) {
  return value == null ||
          (value is String && value.trim().isEmpty) ||
          (value is List && value.isEmpty)
      ? 'Campo obrigatório'
      : null;
}

String? repeatPasswordValidation(String? value, String? password) {
  return passwordValidation(value) ??
      (value != password ? 'As senhas não coincidem' : null);
}

String? passwordValidation(String? value) {
  return requiredValidation(value) ??
      minCharactersValidation(value, 6) ??
      maxCharactersValidation(value, 10) ??
      maxCharactersValidation(value, 10) ??
      uppercaseCharactersValidation(value) ??
      specialCharactersValidation(value);
}

String? minCharactersValidation(String? value, num min) {
  if (value == null) return null;
  return value.trim().length < min ? 'Mínimo de $min caracteres' : null;
}

String? maxCharactersValidation(String? value, num max) {
  if (value == null) return null;
  return value.trim().length > max ? 'Máximo de $max caracteres' : null;
}

String? uppercaseCharactersValidation(String? value, [num min = 1]) {
  if (value == null) return null;
  final regex = RegExp(r'[A-ZÀ-Ú]');
  final quantity = regex.allMatches(value).length;
  return quantity < min
      ? 'Pelo menos $min letra${min > 1 ? 's' : ''} maiúscula${min > 1 ? 's' : ''}'
      : null;
}

String? specialCharactersValidation(String? value, [num min = 1]) {
  if (value == null) return null;
  final regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final quantity = regex.allMatches(value).length;

  return quantity < min
      ? 'Pelo menos $min caractere${min > 1 ? 's' : ''} especial${min > 1 ? 'es' : ''}'
      : null;
}

String? emailValidation(String? value) {
  if (value == null) return null;

  if (value.trim().isEmpty ||
      !RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      ).hasMatch(value)) {
    return 'Digite um e-mail válido';
  }

  return null;
}
