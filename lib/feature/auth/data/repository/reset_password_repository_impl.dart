import 'package:either/either.dart';
import 'package:the_24_hour/feature/auth/data/datasource/reset_password_service.dart';
import 'package:the_24_hour/feature/auth/domain/repository/reset_password_repository.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  const ResetPasswordRepositoryImpl(this.resetPasswordService);

  final ResetPasswordService resetPasswordService;

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await resetPasswordService.requestPasswordResetEmail(email);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
