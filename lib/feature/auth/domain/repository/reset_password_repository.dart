// ignore_for_file: one_member_abstracts

import 'package:either/either.dart';
import 'package:the_24_hour/product/error/failure.dart';

abstract class ResetPasswordRepository {
  Future<Either<Failure, void>> resetPassword({
    required String email,
  });
}
