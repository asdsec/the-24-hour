import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

enum SignUpStatus { initial, loading, completed, error }

@immutable
class SignUpState extends Equatable {
  const SignUpState({
    required this.status,
    this.errorMessage,
  });

  const SignUpState.initial()
      : status = SignUpStatus.initial,
        errorMessage = null;

  final SignUpStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
