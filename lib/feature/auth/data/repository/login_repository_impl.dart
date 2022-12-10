import 'package:either/either.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_local_data_source.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_remote_data_source.dart';
import 'package:the_24_hour/feature/auth/domain/repository/login_repository.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

@immutable
class LoginRepositoryImpl implements LoginRepository {
  const LoginRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthTokenLocalDataSource localDataSource;
  final AuthTokenRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authTokenModel = await remoteDataSource.requestLoginWithEmailAndPassword(
        email: email,
        password: password,
      );
      await localDataSource.cacheAuthToken(authTokenModel);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
