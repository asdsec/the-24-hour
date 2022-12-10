// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginNormal,
  }) : super(const LoginState.initial());

  final LoginWithEmailAndPassword loginNormal;

  Future<void> loginWithEmailAndPassword(AuthorizationParams params) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final failureOrNull = await loginNormal.run(params);
    failureOrNull.fold(
      (failure) => emit(state.copyWith(status: LoginStatus.error, errorMessage: SERVER_FAILURE_MESSAGE)),
      (data) => emit(state.copyWith(status: LoginStatus.completed)),
    );
  }
}
