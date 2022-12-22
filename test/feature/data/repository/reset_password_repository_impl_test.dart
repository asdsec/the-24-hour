import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/data/datasource/reset_password_service.dart';
import 'package:the_24_hour/feature/auth/data/repository/reset_password_repository_impl.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([MockSpec<ResetPasswordService>()])
import 'reset_password_repository_impl_test.mocks.dart';

void main() {
  late MockResetPasswordService mockResetPasswordService;
  late ResetPasswordRepositoryImpl sut;

  setUp(() {
    mockResetPasswordService = MockResetPasswordService();
    sut = ResetPasswordRepositoryImpl(mockResetPasswordService);
  });

  group(
    'resetPassword -',
    () {
      const tEmail = 'test email';

      test(
        'should requestPasswordResetEmail reset when the call to reset password service is successful',
        () async {
          // act
          await sut.resetPassword(email: tEmail);
          // assert
          verify(mockResetPasswordService.requestPasswordResetEmail(tEmail)).called(1);
          verifyNoMoreInteractions(mockResetPasswordService);
        },
      );

      test(
        'should return server failure when the call to service is unsuccessful',
        () async {
          // arrange
          when(
            mockResetPasswordService.requestPasswordResetEmail(tEmail),
          ).thenThrow(ServerException());
          // act
          final result = await sut.resetPassword(email: tEmail);
          // assert
          expect(result, equals(const Left<Failure, void>(ServerFailure())));
        },
      );
    },
  );
}
