import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_local_data_source.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_remote_data_source.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/feature/auth/data/repository/login_repository_impl.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([
  MockSpec<AuthTokenRemoteDataSource>(),
  MockSpec<AuthTokenLocalDataSource>(),
])
import 'login_repository_impl_test.mocks.dart';

void main() {
  late LoginRepositoryImpl sut;
  late MockAuthTokenRemoteDataSource mockRemoteDataSource;
  late MockAuthTokenLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthTokenRemoteDataSource();
    mockLocalDataSource = MockAuthTokenLocalDataSource();
    sut = LoginRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('loginWithEmailAndPassword -', () {
    const tEmail = 'test email';
    const tPassword = 'test password';
    const tAuthTokenModel = AuthTokenModel(
      localId: 'test localId',
      email: 'test email',
      idToken: 'test idToken',
      refreshToken: 'test refreshToken',
      expiresIn: 3600,
    );

    test(
      'should get remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer(
          (_) async => tAuthTokenModel,
        );
        // act
        await sut.loginWithEmailAndPassword(email: tEmail, password: tPassword);
        // assert
        verify(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer(
          (_) async => tAuthTokenModel,
        );
        // act
        await sut.loginWithEmailAndPassword(email: tEmail, password: tPassword);
        // assert
        verify(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verify(mockLocalDataSource.cacheAuthToken(tAuthTokenModel)).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(ServerException());
        // act
        final result = await sut.loginWithEmailAndPassword(email: tEmail, password: tPassword);
        // assert
        verify(
          mockRemoteDataSource.requestLoginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        expect(result, equals(const Left<Failure, void>(ServerFailure())));
      },
    );
  });
}
