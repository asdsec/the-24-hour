import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/repository/login_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
import 'login_with_email_and_password_test.mocks.dart';

void main() {
  late MockLoginRepository mockAuthRepository;
  late LoginWithEmailAndPassword sut;

  setUp(() {
    mockAuthRepository = MockLoginRepository();
    sut = LoginWithEmailAndPassword(mockAuthRepository);
  });

  const tEmail = 'samet@gmail.com';
  const tPassword = '123456';

  test(
    'should call loginWithEmailAndPassword for the email and password for login from the repository',
    () async {
      // arrange
      when(mockAuthRepository.loginWithEmailAndPassword(email: tEmail, password: tPassword)).thenAnswer(
        (_) async => const Right<Failure, void>(null),
      );
      // act
      final result = await sut.run(
        const AuthorizationParams(email: tEmail, password: tPassword),
      );
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(mockAuthRepository.loginWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
