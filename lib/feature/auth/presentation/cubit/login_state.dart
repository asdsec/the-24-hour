import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

enum LoginStatus { initial, loading, completed, error }

@immutable
class LoginState extends Equatable {
  const LoginState({
    required this.status,
    this.errorMessage,
  });

  const LoginState.initial()
      : status = LoginStatus.initial,
        errorMessage = null;

  final LoginStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
