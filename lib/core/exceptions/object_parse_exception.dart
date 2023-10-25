import 'package:devfest23/core/exceptions/exceptions.dart';

final class ObjectParseException extends DevfestException {
  const ObjectParseException(this.stacktraceInfo);

  final StackTrace? stacktraceInfo;

  @override
  String toString() =>
      'We encountered a problem trying to reach the server. We are working to fix it...';
}
