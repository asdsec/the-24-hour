import 'package:either/either.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_local_data_source.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_remote_data_source.dart';
import 'package:the_24_hour/feature/auth/domain/repository/sign_up_repository.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthTokenLocalDataSource localDataSource;
  final AuthTokenRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, void>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final authTokenModel = await remoteDataSource.requestSignUp(
        email: email,
        password: password,
      );
      await localDataSource.cacheAuthToken(authTokenModel);
      return const Right(null);
    } on SignUpException catch (error) {
      return Left(SignUpFailure(error.errorMessage));
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
