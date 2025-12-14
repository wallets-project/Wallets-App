import 'package:dio/dio.dart';
import 'dio_error_mapper.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return res.data;
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    }
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return res.data;
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data, Options? options}) async {
    try {
      final res = await _dio.put(endpoint, data: data, options: options);
      return res.data;
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    }
  }

  Future<dynamic> delete(String endpoint, {dynamic data, Options? options}) async {
    try {
      final res = await _dio.delete(endpoint, data: data, options: options);
      return res.data;
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    }
  }
}
