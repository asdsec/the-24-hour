import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

@immutable
class ServerFailure extends Failure {
  const ServerFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}

@immutable
class LoginFailure extends Failure {
  const LoginFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => null;
}

@immutable
class SignUpFailure extends Failure {
  const SignUpFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => null;
}

@immutable
class CacheFailure extends Failure {
  const CacheFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}
