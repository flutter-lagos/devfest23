import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

base class DevfestException implements Exception {
  const DevfestException();

  factory DevfestException.fromErrorResponse(Response error) {
    try {
      if (error.statusCode! >= 400 && error.statusCode! < 500) {
        return ServerException.fromJson(error.data as Map<String, dynamic>);
      }

      if (error.statusCode! >= 500) {
        return const ClientException(
          exceptionMessage:
              'We encountered a problem reaching the server. Please try again',
        );
      }

      return const ClientException(exceptionMessage: 'An error occurred.');
    } catch (_) {
      return const ClientException(
          exceptionMessage: 'An error occurred.. Please try again');
    }
  }
}
