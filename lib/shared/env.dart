class Env {
  static setBaseUrl(String value) => _baseUrl = value;

  static late String _baseUrl;

  static String get baseUrl => _baseUrl;

  static String get store => 'store';

  static String get login => 'auth/login';

  static String get refreshToken => 'auth/refresh';
}
