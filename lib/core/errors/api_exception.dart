import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromDio(DioException error) {
    final resposneData = error.response?.data;

    if (resposneData is Map) {
      final backendMessage = resposneData['message'];

      if (backendMessage != null) {
        return ApiException(backendMessage.toString());
      }
      final errors = resposneData['errorMessage'];

      if (errors is List && errors.isNotEmpty) {
        return ApiException(errors.map((e) => e['message']).join(', '));
      }
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return ApiException('Connection timeout. Try again.');
    }

    if (error.type == DioExceptionType.connectionTimeout) {
      return ApiException('No internet connection.');
    }
    return ApiException(error.message ?? 'Somthing went wrong!');
  }
  @override
  String toString()=> message;
}
