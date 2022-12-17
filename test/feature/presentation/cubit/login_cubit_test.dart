// ignore_for_file: unawaited_futures

import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@GenerateNiceMocks([MockSpec<LoginWithEmailAndPassword>()])
import 'login_cubit_test.mocks.dart';

void main() {
  late LoginCubit sut;
  late MockLoginWithEmailAndPassword mockLoginWithEmailAndPassword;

  setUp(() {
    mockLoginWithEmailAndPassword = MockLoginWithEmailAndPassword();
    sut = LoginCubit(loginNormal: mockLoginWithEmailAndPassword);
  });

  test(
    'should initial state loading false and error null',
    () async {
      // assert
      expect(sut.state, equals(const LoginState.initial()));
    },
  );

  group('LoginWithEmailAndPassword -', () {
    const tEmail = 'test email';
    const tPassword = 'test password';
    const tAuthParams = AuthorizationParams(email: tEmail, password: tPassword);

    test(
      'should get null data from the use case (means successful use case)',
      () async {
        // arrange
        when(mockLoginWithEmailAndPassword.run(tAuthParams)).thenAnswer(
          (_) async => const Right(null),
        );
        // act
        await sut.loginWithEmailAndPassword(tAuthParams);
        await untilCalled(mockLoginWithEmailAndPassword.run(tAuthParams));
        // assert
        verify(mockLoginWithEmailAndPassword.run(tAuthParams)).called(1);
      },
    );

    test(
      'should emit LoginState with LoginStatus.loading and LoginStatus.completed when the logged in successfully',
      () async {
        // arrange
        when(mockLoginWithEmailAndPassword.run(tAuthParams)).thenAnswer(
          (_) async => const Right(null),
        );
        // assert later
        const expectedOrder = [
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.completed),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.loginWithEmailAndPassword(tAuthParams);
      },
    );

    test(
      'should emit LoginState with LoginStatus.loading and LoginStatus.error when use case fails',
      () async {
        // arrange
        when(mockLoginWithEmailAndPassword.run(tAuthParams)).thenAnswer(
          (_) async => const Left(ServerFailure()),
        );
        // assert later
        final expectedOrder = [
          const LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.error, errorMessage: LocaleKeys.errors_network_serverFailure.tr()),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.loginWithEmailAndPassword(tAuthParams);
      },
    );

    test(
      'should emit LoginState with LoginStatus.loading and LoginStatus.error when use case fails with login error',
      () async {
        // arrange
        when(mockLoginWithEmailAndPassword.run(tAuthParams)).thenAnswer(
          (_) async => Left(LoginFailure(LocaleKeys.errors_network_invalidEmailOrPassword.tr())),
        );
        // assert later
        final expectedOrder = [
          const LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.error, errorMessage: LocaleKeys.errors_network_invalidEmailOrPassword.tr()),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.loginWithEmailAndPassword(tAuthParams);
      },
    );
  });
}
