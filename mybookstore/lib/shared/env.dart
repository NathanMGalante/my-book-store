class Env {
  static setBaseUrl(String value) => _baseUrl = value;

  static late String _baseUrl;

  static String get baseUrl => _baseUrl;

  static String get store => 'v1/store';

  static String get login => 'v1/auth';

  static String get refreshToken => 'v1/auth/validateToken';
}
