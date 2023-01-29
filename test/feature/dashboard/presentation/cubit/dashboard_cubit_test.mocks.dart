// Mocks generated by Mockito 5.3.2 from annotations
// in the_24_hour/test/feature/dashboard/presentation/cubit/dashboard_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:either/either.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart' as _i7;
import 'package:the_24_hour/feature/dashboard/domain/repository/task_repository.dart'
    as _i2;
import 'package:the_24_hour/feature/dashboard/domain/usecase/list_tasks_by_day.dart'
    as _i4;
import 'package:the_24_hour/product/error/failure.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTaskRepository_0 extends _i1.SmartFake
    implements _i2.TaskRepository {
  _FakeTaskRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ListTasksByDay].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockListTasksByDay extends _i1.Mock implements _i4.ListTasksByDay {
  @override
  _i2.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeTaskRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TaskRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, Iterable<_i7.Task>>> run(
          _i4.ListTaskParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #run,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, Iterable<_i7.Task>>>.value(
                _FakeEither_1<_i6.Failure, Iterable<_i7.Task>>(
          this,
          Invocation.method(
            #run,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, Iterable<_i7.Task>>>.value(
                _FakeEither_1<_i6.Failure, Iterable<_i7.Task>>(
          this,
          Invocation.method(
            #run,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, Iterable<_i7.Task>>>);
}