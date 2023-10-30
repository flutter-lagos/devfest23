import 'package:devfest23/core/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

final class LoginForm extends Equatable {
  final EmailAddress emailAddress;
  final Password password;

  const LoginForm({required this.emailAddress, required this.password});

  LoginForm.empty()
      : this(
          emailAddress: EmailAddress(''),
          password: Password(''),
        );

  LoginForm copyWith({EmailAddress? emailAddress, Password? password}) {
    return LoginForm(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
    );
  }

  LoginRequestDto toDto() {
    return LoginRequestDto(
      email: emailAddress.valueOrCrash,
      password: password.valueOrCrash,
    );
  }

  bool get isValid => formValidationError == null;

  String? get formValidationError {
    if (!emailAddress.isValid) {
      return emailAddress.validationError;
    }

    if (!password.isValid) {
      return password.validationError;
    }

    return null;
  }

  @override
  List<Object?> get props => [emailAddress, password];
}

final class EmailAddress extends Equatable {
  static final regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final String _value;
  final String? _validationError;

  factory EmailAddress(String input) {
    String failure = '';
    if (!regex.hasMatch(input)) {
      failure = 'Please enter a valid email address';
    }

    if (input.isEmpty) {
      failure = 'Email cannot be empty';
    }

    if (failure.isNotEmpty) return EmailAddress._(input, failure);
    return EmailAddress._(input, null);
  }

  const EmailAddress._(this._value, this._validationError);

  String get valueOrCrash {
    if (!isValid) {
      throw ErrorDescription('Please enter a valid email');
    }

    return value;
  }

  String get value => _value;

  String? get validationError => _validationError;

  bool get isValid => _validationError == null;

  @override
  List<Object?> get props => [_value, _validationError];
}

final class Password extends Equatable {
  final String _value;
  final String? _validationError;

  factory Password(String input) {
    String failure = '';

    if (input.isEmpty) {
      failure = 'Ticket Number cannot be empty';
    }

    if (failure.isNotEmpty) return Password._(input, failure);
    return Password._(input, null);
  }

  const Password._(this._value, this._validationError);

  String get valueOrCrash {
    if (!isValid) {
      throw ErrorDescription('Please enter a valid password');
    }

    return value;
  }

  String get value => _value;

  String? get validationError => _validationError;

  bool get isValid => _validationError == null;

  @override
  List<Object?> get props => [_value, _validationError];
}
