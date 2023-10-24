import 'package:devfest23/core/exceptions/exceptions.dart';

final class ServerException extends DevfestException {
  final String message;
  final String error;

  const ServerException({required this.message, required this.error});

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(
        message: json['message'] ?? '',
        error: json['error'] ?? '',
      );

  @override
  String toString() => error;
}
