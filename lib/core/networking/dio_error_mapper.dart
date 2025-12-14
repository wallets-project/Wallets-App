import 'package:dio/dio.dart';
import 'api_exception.dart';

class DioErrorMapper {
  static ApiException map(DioException e) {
    final res = e.response;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException('انتهت مهلة الاتصال بالسيرفر، حاول مرة أخرى.');
    }

    if (res != null) {
      final int? statusCode = res.statusCode;
      final dynamic data = res.data;

      String message = 'حدث خطأ غير متوقع';

      if (statusCode != null) {
        if (statusCode >= 400 && statusCode < 500) {
          message = 'خطأ في البيانات المرسلة أو صلاحيات الوصول.';
        } else if (statusCode >= 500) {
          message = 'مشكلة في السيرفر، حاول لاحقاً.';
        }
      }

      if (data is Map<String, dynamic>) {
        final m = data['message'];
        final err = data['error'];
        if (m is String && m.isNotEmpty) message = m;
        if (err is String && err.isNotEmpty) message = err;
      }

      return ApiException(message, statusCode: statusCode, data: data);
    }

    return ApiException('تعذر الاتصال بالسيرفر، تأكد من اتصال الإنترنت.');
  }
}
