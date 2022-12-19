import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/repository/sign_up_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/sign_up.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([MockSpec<SignUpRepository>()])
import 'sign_up_test.mocks.dart';

void main() {
  late MockSignUpRepository mockAuthRepository;
  late SignUp sut;

  setUp(() {
    mockAuthRepository = MockSignUpRepository();
    sut = SignUp(mockAuthRepository);
  });

  const tEmail = 'test email';
  const tPassword = 'test password';

  test(
    'should call signUp for the email and password for signUp from the repository',
    () async {
      // arrange
      when(mockAuthRepository.signUp(email: tEmail, password: tPassword)).thenAnswer(
        (_) async => const Right<Failure, void>(null),
      );
      // act
      final result = await sut.run(
        const AuthorizationParams(email: tEmail, password: tPassword),
      );
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(mockAuthRepository.signUp(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
