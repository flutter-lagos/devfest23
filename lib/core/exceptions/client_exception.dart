import 'package:devfest23/core/exceptions/exceptions.dart';

final class ClientException extends DevfestException {
  final String exceptionMessage;

  const ClientException({required this.exceptionMessage});

  @override
  String toString() => exceptionMessage;
}
