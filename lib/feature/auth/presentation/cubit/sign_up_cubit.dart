import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/sign_up.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_state.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.signUp,
  }) : super(const SignUpState.initial());

  final SignUp signUp;

  Future<void> signUpWithPassword(AuthorizationParams params) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final failureOrNull = await signUp.run(params);
    failureOrNull.fold(
      (failure) => emit(state.copyWith(status: SignUpStatus.error, errorMessage: _getErrorMessage(failure))),
      (data) => emit(state.copyWith(status: SignUpStatus.completed)),
    );
  }

  String _getErrorMessage(Failure failure) {
    if (failure is SignUpFailure) {
      return failure.message;
    } else {
      return LocaleKeys.errors_network_serverFailure.tr();
    }
  }

  void clearState() => emit(const SignUpState.initial());
}
