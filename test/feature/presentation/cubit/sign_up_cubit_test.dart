// ignore_for_file: unawaited_futures

import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/sign_up.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_state.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@GenerateNiceMocks([MockSpec<SignUp>()])
import 'sign_up_cubit_test.mocks.dart';

void main() {
  late SignUpCubit sut;
  late MockSignUp mockSignUp;

  setUp(() {
    mockSignUp = MockSignUp();
    sut = SignUpCubit(signUp: mockSignUp);
  });

  test(
    'should initial state loading false and error null',
    () async {
      // assert
      expect(sut.state, equals(const SignUpState.initial()));
    },
  );

  group('signUp -', () {
    const tEmail = 'test email';
    const tPassword = 'test password';
    const tAuthParams = AuthorizationParams(email: tEmail, password: tPassword);

    test(
      'should get null data from the use case (means successful use case)',
      () async {
        // arrange
        when(mockSignUp.run(tAuthParams)).thenAnswer(
          (_) async => const Right(null),
        );
        // act
        await sut.signUpWithPassword(tAuthParams);
        await untilCalled(mockSignUp.run(tAuthParams));
        // assert
        verify(mockSignUp.run(tAuthParams)).called(1);
      },
    );

    test(
      'should emit SignUpState with SignUpStatus.loading and SignUpStatus.completed when the signed up successfully',
      () async {
        // arrange
        when(mockSignUp.run(tAuthParams)).thenAnswer(
          (_) async => const Right(null),
        );
        // assert later
        const expectedOrder = [
          SignUpState(status: SignUpStatus.loading),
          SignUpState(status: SignUpStatus.completed),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.signUpWithPassword(tAuthParams);
      },
    );

    test(
      'should emit SignUpState with SignUpStatus.loading and SignUpStatus.error when use case fails',
      () async {
        // arrange
        when(mockSignUp.run(tAuthParams)).thenAnswer(
          (_) async => const Left(ServerFailure()),
        );
        // assert later
        final expectedOrder = [
          const SignUpState(status: SignUpStatus.loading),
          SignUpState(status: SignUpStatus.error, errorMessage: LocaleKeys.errors_network_serverFailure.tr()),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.signUpWithPassword(tAuthParams);
      },
    );

    test(
      'should emit SignUpState with SignUpStatus.loading and SignUpStatus.error when use case fails with sign up error',
      () async {
        // arrange
        when(mockSignUp.run(tAuthParams)).thenAnswer(
          (_) async => Left(SignUpFailure(LocaleKeys.errors_network_emailExists.tr())),
        );
        // assert later
        final expectedOrder = [
          const SignUpState(status: SignUpStatus.loading),
          SignUpState(status: SignUpStatus.error, errorMessage: LocaleKeys.errors_network_emailExists.tr()),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.signUpWithPassword(tAuthParams);
      },
    );
  });
}
