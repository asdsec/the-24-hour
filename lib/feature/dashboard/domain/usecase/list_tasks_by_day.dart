import 'package:either/either.dart';
import 'package:flutter/foundation.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/feature/dashboard/domain/repository/task_repository.dart';
import 'package:the_24_hour/product/base/usecase.dart';
import 'package:the_24_hour/product/error/failure.dart';

@immutable
class ListTasksByDay implements UseCase<Iterable<Task>, ListTaskParams> {
  const ListTasksByDay(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, Iterable<Task>>> run(ListTaskParams params) {
    return repository.listTasksByDay(params.dayId);
  }
}

@immutable
class ListTaskParams {
  const ListTaskParams({
    required this.dayId,
  });

  final int dayId;
}
