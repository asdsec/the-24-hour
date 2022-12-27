import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/reset_password.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPassword) : super(const ResetPasswordState.initial());

  final ResetPassword _resetPassword;

  Future<void> sendResetPasswordEmail(EmailParams params) async {
    emit(state.copyWith(isLoading: true));
    final failureOrNull = await _resetPassword.run(params);
    failureOrNull.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: LocaleKeys.errors_network_serverFailure.tr(),
        ),
      ),
      (data) => emit(state.copyWith(isLoading: false, completed: true)),
    );
  }
}

@immutable
class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.completed = false,
  });

  const ResetPasswordState.initial()
      : isLoading = false,
        errorMessage = null,
        completed = false;

  final bool isLoading;
  final String? errorMessage;
  final bool completed;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        completed,
      ];

  ResetPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? completed,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? false,
      errorMessage: errorMessage,
      completed: completed ?? false,
    );
  }
}
