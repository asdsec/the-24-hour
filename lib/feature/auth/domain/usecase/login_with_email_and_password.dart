import 'package:either/either.dart';
import 'package:flutter/foundation.dart';
import 'package:the_24_hour/feature/auth/domain/repository/login_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/product/base/usecase.dart';
import 'package:the_24_hour/product/error/failure.dart';

@immutable
class LoginWithEmailAndPassword implements UseCase<void, AuthorizationParams> {
  const LoginWithEmailAndPassword(this.repository);

  final LoginRepository repository;

  @override
  Future<Either<Failure, void>> run(AuthorizationParams params) {
    return repository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
