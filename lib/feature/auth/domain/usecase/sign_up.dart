import 'package:either/either.dart';
import 'package:flutter/foundation.dart';
import 'package:the_24_hour/feature/auth/domain/repository/sign_up_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/product/base/usecase.dart';
import 'package:the_24_hour/product/error/failure.dart';

@immutable
class SignUp implements UseCase<void, AuthorizationParams> {
  const SignUp(this.repository);

  final SignUpRepository repository;

  @override
  Future<Either<Failure, void>> run(AuthorizationParams params) {
    return repository.signUp(
      email: params.email,
      password: params.password,
    );
  }
}
