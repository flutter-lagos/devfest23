import 'devfest_exception.dart';

final class EmptyException extends DevfestException {
  const EmptyException();

  @override
  String toString() => '';
}
