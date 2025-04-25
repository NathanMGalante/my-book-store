import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/env.dart';

class RestClient {
  static final RestClient _instance = RestClient._internal();

  late final Dio _publicClient;
  late final Dio _privateClient;

  static Dio get public => _instance._publicClient;

  static Dio get private => _instance._privateClient;

  RestClient._internal() {
    final baseOptions = BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
      responseType: ResponseType.plain,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    _publicClient = Dio(baseOptions);
    _privateClient = Dio(baseOptions);
    _privateClient.interceptors.add(_authInterceptor());
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = AuthController().token;
        if (token != null && token.isNotEmpty) {
          if (JwtDecoder.isExpired(token)) {
            token = await AuthController().refreshToken();
          }
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    );
  }
}

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Converter respostas de texto para JSON
    if (err.response != null && err.response!.data is String) {
      try {
        err.response!.data = {'message': err.response!.data};
      } catch (e) {
        err.response!.data = {'message': 'Erro desconhecido'};
      }
    }

    // Tratar erros de parsing
    if (err.type == DioExceptionType.unknown && err.error is FormatException) {
      err = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: DioExceptionType.badResponse,
        error: 'Resposta do servidor em formato inválido',
      );
    }

    super.onError(err, handler);
  }
}
