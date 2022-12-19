import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginNormal,
  }) : super(const LoginState.initial());

  final LoginWithEmailAndPassword loginNormal;

  Future<void> loginWithEmailAndPassword(AuthorizationParams params) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final failureOrNull = await loginNormal.run(params);
    failureOrNull.fold(
      (failure) => emit(state.copyWith(status: LoginStatus.error, errorMessage: _getErrorMessage(failure))),
      (data) => emit(state.copyWith(status: LoginStatus.completed)),
    );
  }

  String _getErrorMessage(Failure failure) {
    if (failure is LoginFailure) {
      return failure.message;
    } else {
      return LocaleKeys.errors_network_serverFailure.tr();
    }
  }

  void clearState() => emit(const LoginState.initial());
}
