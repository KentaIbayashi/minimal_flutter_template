import 'package:dio/dio.dart';
import 'package:minimal_flutter_template/logger.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = 'YOUR_API_BASE_URL';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      logger.e(e.message);
      rethrow;
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      logger.e(e.message);
      rethrow;
    }
  }
}
