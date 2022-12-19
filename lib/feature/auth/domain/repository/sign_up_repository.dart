// ignore_for_file: one_member_abstracts

import 'package:either/either.dart';
import 'package:the_24_hour/product/error/failure.dart';

abstract class SignUpRepository {
  Future<Either<Failure, void>> signUp({
    required String email,
    required String password,
  });
}
