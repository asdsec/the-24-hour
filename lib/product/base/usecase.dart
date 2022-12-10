import 'package:either/either.dart';
import 'package:the_24_hour/product/error/failure.dart';

mixin UseCase<T, P> {
  Future<Either<Failure, T>> run(P params);
}
