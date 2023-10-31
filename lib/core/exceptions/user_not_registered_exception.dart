import 'package:devfest23/core/exceptions/devfest_exception.dart';

final class UserNotRegisteredException extends DevfestException {
  const UserNotRegisteredException();

  @override
  String toString() {
    return 'Your email is not in our database. Please register now.';
  }
}
