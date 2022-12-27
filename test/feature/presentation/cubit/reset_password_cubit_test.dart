// ignore_for_file: unawaited_futures

import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/reset_password.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@GenerateNiceMocks([
  MockSpec<ResetPassword>(),
])
import 'reset_password_cubit_test.mocks.dart';

void main() {
  late ResetPasswordCubit sut;
  late MockResetPassword mockResetPassword;

  setUp(() {
    mockResetPassword = MockResetPassword();
    sut = ResetPasswordCubit(mockResetPassword);
  });

  test(
    'should initial state isLoading is false and errorMessage is null',
    () async {
      // assert
      expect(sut.state, const ResetPasswordState.initial());
    },
  );

  group('sendResetPasswordEmail -', () {
    const tEmailParam = EmailParams('test email');

    test(
      'should be use case called without exception',
      () async {
        // arrange
        when(mockResetPassword.run(tEmailParam)).thenAnswer(
          (_) async => const Right(null),
        );
        // act
        await sut.sendResetPasswordEmail(tEmailParam);
        await untilCalled(mockResetPassword.run(tEmailParam));
        // assert
        verify(mockResetPassword.run(tEmailParam)).called(1);
      },
    );

    test(
      'should emit ResetPasswordState with [isLoading = true] and [isLoading = false] when the sendResetPasswordEmail successfully',
      () async {
        // arrange
        when(mockResetPassword.run(tEmailParam)).thenAnswer(
          (_) async => const Right(null),
        );
        // assert later
        const expectedOrder = [
          ResetPasswordState(isLoading: true),
          ResetPasswordState(),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.sendResetPasswordEmail(tEmailParam);
      },
    );

    test(
      'should emit ResetPasswordState with [isLoading = true], [isLoading = false, errorMessage = ...] when use case fails',
      () async {
        // arrange
        when(mockResetPassword.run(tEmailParam)).thenAnswer(
          (_) async => const Left(ServerFailure()),
        );
        // assert later
        final expectedOrder = [
          const ResetPasswordState(isLoading: true),
          ResetPasswordState(errorMessage: LocaleKeys.errors_network_serverFailure.tr()),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.sendResetPasswordEmail(tEmailParam);
      },
    );
  });
}
