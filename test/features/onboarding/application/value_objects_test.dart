import 'package:devfest23/features/onboarding/application/auth/auth_value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit tests for Authentication feature', () {
    test('Email address value object test', () {
      EmailAddress address = EmailAddress('');

      expect(address.isValid, false); // invalid email input
      expect(address.validationError, 'Email cannot be empty');

      address = EmailAddress('john');
      expect(address.isValid, false);
      expect(address.validationError, 'Please enter a valid email address');
      // ensure our value object holds onto the value even invalid
      expect(address.value, 'john');

      address = EmailAddress('johndoe@gmail.com');
      expect(address.isValid, true); // valid email input
      expect(address.validationError, null);
      expect(address.value, 'johndoe@gmail.com');
    });

    test('Password value object test', () {
      Password password = Password('');

      expect(password.isValid, false); // invalid password input
      expect(password.validationError, 'Ticket Number cannot be empty');

      password = Password('1234');
      expect(password.isValid, true);
      expect(password.value, '1234');

      password = Password('123456');
      expect(password.isValid, true);
      expect(password.validationError, null);
      expect(password.value, '123456');
    });

    test('LoginForm entity test', () {
      LoginForm form = LoginForm.empty();

      expect(form.isValid, false);
      expect(form.formValidationError, 'Email cannot be empty');

      form = form.copyWith(emailAddress: EmailAddress('johndoe@gmail.com'));

      expect(form.isValid, false);
      expect(form.formValidationError, 'Ticket Number cannot be empty');
      expect(form.emailAddress.value, 'johndoe@gmail.com');

      form = form.copyWith(password: Password('123456'));
      expect(form.isValid, true);
      expect(form.formValidationError, null);

      expect(form.emailAddress.value, 'johndoe@gmail.com');
      expect(form.password.value, '123456');
    });
  });
}
