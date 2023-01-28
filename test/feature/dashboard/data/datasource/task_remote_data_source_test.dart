import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/dashboard/data/datasource/task_remote_data_source.dart';
import 'package:the_24_hour/feature/dashboard/data/model/task_model.dart';
import 'package:the_24_hour/product/enum/firestore_paths.dart';

import '../../../../fixture/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
])
import 'task_remote_data_source_test.mocks.dart';

void main() {
  late TaskRemoteDataSource sut;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference mockUsersCollectionReference;
  late MockCollectionReference mockTasksCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot1;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot2;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUsersCollectionReference = MockCollectionReference();
    mockTasksCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot1 = MockQueryDocumentSnapshot();
    mockQueryDocumentSnapshot2 = MockQueryDocumentSnapshot();
    sut = TaskRemoteDataSourceImpl(mockFirebaseFirestore);
  });

  group('getTasksByDay -', () {
    const tUserId = 'GmFqfBWsA3XjY81priIwdbM43bs2';
    final tTaskModel = TaskModel(
      id: 'test id',
      title: 'test title',
      description: 'test description',
      done: true,
      startDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
      endDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
    );

    Map<String, dynamic> fixtureTaskMap() {
      const startDate = 'start_date';
      const endDate = 'end_date';

      final map = jsonDecode(fixture('task.json')) as Map<String, dynamic>;
      map[startDate] =
          Timestamp.fromMicrosecondsSinceEpoch(map[startDate] as int);
      map[endDate] = Timestamp.fromMicrosecondsSinceEpoch(map[endDate] as int);
      return map;
    }

    void whenMethodsCalled() {
      when(mockFirebaseFirestore.collection(FirestorePaths.users.name))
          .thenReturn(mockUsersCollectionReference);
      when(mockUsersCollectionReference.doc(tUserId))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.collection(FirestorePaths.tasks.name))
          .thenReturn(mockTasksCollectionReference);
      when(mockTasksCollectionReference.get()).thenAnswer(
        (_) async => mockQuerySnapshot,
      );
      when(mockQuerySnapshot.docs).thenReturn(
        [mockQueryDocumentSnapshot1, mockQueryDocumentSnapshot1],
      );
      when(mockQueryDocumentSnapshot1.data()).thenReturn(fixtureTaskMap());
      when(mockQueryDocumentSnapshot2.data()).thenReturn(fixtureTaskMap());
    }

    test(
      'should perform a get method on the tasks of user with dayId being the firestore endpoint',
      () async {
        // arrange
        whenMethodsCalled();
        // act
        await sut.getTasksByDay(1);
        // assert
        verify(mockFirebaseFirestore.collection(FirestorePaths.users.name))
            .called(1);
        verify(mockUsersCollectionReference.doc(tUserId)).called(1);
        verify(mockDocumentReference.collection(FirestorePaths.tasks.name))
            .called(1);
        verify(mockTasksCollectionReference.get()).called(1);
        verify(mockQuerySnapshot.docs).called(1);
        verifyNoMoreInteractions(mockFirebaseFirestore);
        verifyNoMoreInteractions(mockUsersCollectionReference);
        verifyNoMoreInteractions(mockDocumentReference);
        verifyNoMoreInteractions(mockTasksCollectionReference);
        verifyNoMoreInteractions(mockQuerySnapshot);
      },
    );

    test(
      'should return Iterable<TaskModel> when the request is (success)',
      () async {
        // arrange
        whenMethodsCalled();
        // act
        final result = await sut.getTasksByDay(1);
        // assert
        result.map(
          (r) => expect(r, equals(tTaskModel)),
        );
      },
    );
  });
}
