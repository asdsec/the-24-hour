import 'package:either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/feature/dashboard/domain/repository/task_repository.dart';
import 'package:the_24_hour/feature/dashboard/domain/usecase/list_tasks_by_day.dart';

@GenerateNiceMocks([MockSpec<TaskRepository>()])
import 'list_tasks_by_day_test.mocks.dart';

void main() {
  late ListTasksByDay sut;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    sut = ListTasksByDay(mockTaskRepository);
  });

  const tDayId = 1;
  final tTask = Task(
    id: 'test id',
    title: 'test title',
    description: 'test description',
    done: true,
    startDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
    endDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
  );

  test(
    'should call listTasksById for dayId for daily tasks from the repository',
    () async {
      // arrange
      when(mockTaskRepository.listTasksByDay(tDayId)).thenAnswer(
        (_) async => Right([tTask]),
      );
      final result = await sut.run(const ListTaskParams(dayId: tDayId));
      // assert
      result.fold(
        (failure) => null,
        (tasks) => expect(tasks, [tTask]),
      );
      verify(mockTaskRepository.listTasksByDay(tDayId)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}
