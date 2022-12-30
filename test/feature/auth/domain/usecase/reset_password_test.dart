import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/repository/reset_password_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/reset_password.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([MockSpec<ResetPasswordRepository>()])
import 'reset_password_test.mocks.dart';

void main() {
  late MockResetPasswordRepository mockResetPasswordRepository;
  late ResetPassword sut;

  setUp(() {
    mockResetPasswordRepository = MockResetPasswordRepository();
    sut = ResetPassword(mockResetPasswordRepository);
  });

  const tEmail = 'samet@gmail.com';

  test(
    'should call resetPassword for the email for ResetPassword from the repository',
    () async {
      // arrange
      when(mockResetPasswordRepository.resetPassword(email: tEmail)).thenAnswer(
        (_) async => const Right<Failure, void>(null),
      );
      // act
      final result = await sut.run(
        const EmailParams(tEmail),
      );
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(mockResetPasswordRepository.resetPassword(email: tEmail)).called(1);
      verifyNoMoreInteractions(mockResetPasswordRepository);
    },
  );
}
