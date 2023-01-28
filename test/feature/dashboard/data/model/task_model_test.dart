import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_24_hour/feature/dashboard/data/model/task_model.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/product/error/exception.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tTaskModel = TaskModel(
    id: 'test id',
    title: 'test title',
    description: 'test description',
    done: true,
    startDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
    endDate: DateTime.fromMicrosecondsSinceEpoch(1674162000222000),
  );

  test(
    'should be a subclass of Task entity',
    () async {
      // assert
      expect(tTaskModel, isA<Task>());
    },
  );

  group('fromJson -', () {
    test(
      'should return a valid model when the start_date and end_date properties are Timestamp',
      () async {
        // arrange
        final jsonMap =
            json.decode(fixture('task.json')) as Map<String, dynamic>;
        jsonMap['start_date'] =
            Timestamp.fromMicrosecondsSinceEpoch(jsonMap['start_date'] as int);
        jsonMap['end_date'] =
            Timestamp.fromMicrosecondsSinceEpoch(jsonMap['end_date'] as int);
        // act
        final result = TaskModel.fromJson(jsonMap);
        // assert
        expect(result, tTaskModel);
      },
    );

    test(
      'should throw NullFieldServerException when the start_date and end_date properties are different from Timestamp',
      () async {
        // arrange
        final jsonMap =
            json.decode(fixture('task.json')) as Map<String, dynamic>;
        // act
        const call = TaskModel.fromJson;
        // assert
        expect(
          () => call(jsonMap),
          throwsA(const TypeMatcher<NullFieldServerException>()),
        );
      },
    );
  });

  group('toJson -', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTaskModel.toJson();
        // assert
        final expected = {
          'id': 'test id',
          'title': 'test title',
          'description': 'test description',
          'done': true,
          'start_date': Timestamp.fromMicrosecondsSinceEpoch(1674162000222000),
          'end_date': Timestamp.fromMicrosecondsSinceEpoch(1674162000222000)
        };
        expect(result, expected);
      },
    );
  });
}
