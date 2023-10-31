import 'package:equatable/equatable.dart';

final class LoginRequestDto extends Equatable {
  final String email;
  final String password;

  const LoginRequestDto({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
