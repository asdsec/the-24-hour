import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/dashboard/data/datasource/task_remote_data_source.dart';
import 'package:the_24_hour/feature/dashboard/data/model/task_model.dart';
import 'package:the_24_hour/feature/dashboard/data/repository/task_repository_impl.dart';
import 'package:the_24_hour/feature/dashboard/domain/repository/task_repository.dart';
import 'package:the_24_hour/product/error/exception.dart';
import 'package:the_24_hour/product/error/failure.dart';

@GenerateNiceMocks([
  MockSpec<TaskRemoteDataSource>(),
])
import 'task_repository_impl_test.mocks.dart';

void main() {
  late TaskRepository sut;
  late MockTaskRemoteDataSource mockTaskRemoteDataSource;

  setUp(() {
    mockTaskRemoteDataSource = MockTaskRemoteDataSource();
    sut = TaskRepositoryImpl(taskRemoteDataSource: mockTaskRemoteDataSource);
  });

  group('group name', () {
    const tDayId = 1;
    final tTaskModel = TaskModel(
      id: 'test id',
      title: 'test title',
      description: 'test description',
      done: true,
      startDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
      endDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
    );

    test(
      'should get remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockTaskRemoteDataSource.getTasksByDay(tDayId)).thenAnswer(
          (_) async => [tTaskModel],
        );
        // act
        final result = await sut.listTasksByDay(tDayId);
        // assert
        verify(mockTaskRemoteDataSource.getTasksByDay(tDayId)).called(1);
        verifyNoMoreInteractions(mockTaskRemoteDataSource);
        expect(
          result.fold((failure) => null, (data) => data),
          equals([tTaskModel]),
        );
      },
    );

    // TODO(sametdmr): add more complex test cases

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockTaskRemoteDataSource.getTasksByDay(tDayId)).thenThrow(
          ServerException(),
        );
        // act
        final result = await sut.listTasksByDay(tDayId);
        // assert
        verify(mockTaskRemoteDataSource.getTasksByDay(tDayId)).called(1);
        verifyNoMoreInteractions(mockTaskRemoteDataSource);
        expect(result, equals(const Left<Failure, dynamic>(ServerFailure())));
      },
    );
  });
}
