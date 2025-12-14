import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef TokenProvider = Future<String?> Function();

class DioFactory {
  static Dio create({
    required String baseUrl,
    TokenProvider? tokenProvider,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: <String, dynamic>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Token interceptor
    if (tokenProvider != null) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final String? token = await tokenProvider();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
        ),
      );
    }

    // Logger فقط في غير الريليز
    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          // خليها false لتجنب طباعة التوكن
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }

    return dio;
  }
}
