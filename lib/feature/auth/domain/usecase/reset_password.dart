import 'package:either/either.dart';
import 'package:flutter/foundation.dart';
import 'package:the_24_hour/feature/auth/domain/repository/reset_password_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/product/base/usecase.dart';
import 'package:the_24_hour/product/error/failure.dart';

@immutable
class ResetPassword implements UseCase<void, EmailParams> {
  const ResetPassword(this.repository);

  final ResetPasswordRepository repository;

  @override
  Future<Either<Failure, void>> run(EmailParams params) {
    return repository.resetPassword(email: params.email);
  }
}
