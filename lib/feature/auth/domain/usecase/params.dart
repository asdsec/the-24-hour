import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthorizationParams extends Equatable {
  const AuthorizationParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

@immutable
class EmailParams extends Equatable {
  const EmailParams(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}
