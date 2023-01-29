// ignore_for_file: unawaited_futures

import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/feature/dashboard/domain/usecase/list_tasks_by_day.dart';
import 'package:the_24_hour/feature/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@GenerateNiceMocks([
  MockSpec<ListTasksByDay>(),
])
import 'dashboard_cubit_test.mocks.dart';

void main() {
  late DashboardCubit sut;
  late MockListTasksByDay mockListTasksByDay;

  setUp(() {
    mockListTasksByDay = MockListTasksByDay();
    sut = DashboardCubit(mockListTasksByDay);
  });

  test(
    'should initial state loading false and tasks empty',
    () async {
      // assert
      expect(sut.state, equals(const DashboardState.initial()));
      expect(sut.state.isLoading, isFalse);
      expect(sut.state.tasks, isNull);
    },
  );

  group('getTasksByDay -', () {
    const tListTaskParams = ListTaskParams(dayId: 1);
    final tTasks = [
      Task(
        id: 'test id 1',
        description: 'test description 1',
        title: 'test title 1',
        done: false,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(seconds: 5)),
      ),
      Task(
        id: 'test id 2',
        description: 'test description 2',
        title: 'test title 2',
        done: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(seconds: 10)),
      ),
    ];

    test(
      'should get the tasks with the specified day id from the usecase',
      () async {
        // arrange
        when(mockListTasksByDay.run(tListTaskParams)).thenAnswer(
          (_) async => Right(tTasks),
        );
        // act
        await sut.getTasksByDay(tListTaskParams);
        await untilCalled(mockListTasksByDay.run(tListTaskParams));
        // assert
        verify(mockListTasksByDay.run(tListTaskParams)).called(1);
        expect(sut.state, DashboardState(isLoading: false, tasks: tTasks));
      },
    );

    test(
      'should emit [isLoading=true, tasks=empty] and [isLoading=false, tasks=expected] respectively',
      () async {
        // arrange
        when(mockListTasksByDay.run(tListTaskParams)).thenAnswer(
          (_) async => Right(tTasks),
        );
        // assert later
        final expectedOrder = [
          const DashboardState(isLoading: true),
          DashboardState(isLoading: false, tasks: tTasks),
        ];
        expectLater(sut.stream, emitsInOrder(expectedOrder));
        // act
        await sut.getTasksByDay(tListTaskParams);
      },
    );

    test(
      'should emit [isLoading=true, errorMessage=null] and [isLoading=false, errorMessage=expected] respectively',
      () async {
        // arrange
        when(mockListTasksByDay.run(tListTaskParams)).thenAnswer(
          (_) async => const Left(ServerFailure()),
        );
        // assert later
        final expected = [
          const DashboardState(isLoading: true),
          DashboardState(
            isLoading: false,
            errorMessage: LocaleKeys.errors_network_serverFailure.tr(),
          ),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        await sut.getTasksByDay(tListTaskParams);
      },
    );
  });
}
