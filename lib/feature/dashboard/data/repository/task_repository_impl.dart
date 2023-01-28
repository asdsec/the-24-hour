import 'package:either/either.dart';
import 'package:the_24_hour/feature/dashboard/data/datasource/task_remote_data_source.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/feature/dashboard/domain/repository/task_repository.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl({required this.taskRemoteDataSource});

  final TaskRemoteDataSource taskRemoteDataSource;

  @override
  Future<Either<Failure, Task>> getTaskById(String id) {
    // TODO: implement getTaskById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Iterable<Task>>> listTasksByDay(int dayId) async {
    try {
      final tasks = await taskRemoteDataSource.getTasksByDay(dayId);
      return Right(tasks);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Task>> removeTask(String id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }
}
