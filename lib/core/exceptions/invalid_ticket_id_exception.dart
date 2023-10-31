import 'package:devfest23/core/exceptions/devfest_exception.dart';

final class InvalidTicketIdException extends DevfestException {
  const InvalidTicketIdException();

  @override
  String toString() {
    return 'Invalid ticket Id. Please ensure the ticket id(password) provided is correct';
  }
}
