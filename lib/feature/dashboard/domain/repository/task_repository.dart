import 'package:either/either.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/product/error/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure, Iterable<Task>>> listTasksByDay(int dayId);
  Future<Either<Failure, Task>> getTaskById(String id);
  Future<Either<Failure, Task>> removeTask(String id);
}
