import 'package:either/either.dart';
import 'package:the_24_hour/product/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}
