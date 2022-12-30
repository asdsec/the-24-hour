import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_24_hour/feature/auth/data/model/firebase_error_model.dart';
import 'package:the_24_hour/feature/auth/data/model/firebase_errors.dart';
import 'package:the_24_hour/product/error/exception.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tError = Error(code: 400, message: FirebaseErrors.invalidPassword);
  const tFirebaseErrorModel = FirebaseErrorModel(error: tError);

  group('Error -', () {
    group('fromJson -', () {
      test(
        'should return a valid model when the JSON ia valid error',
        () async {
          // arrange
          final jsonMap = json.decode(fixture('auth_valid_firebase_error.json')) as Map<String, dynamic>;
          // act
          final result = Error.fromJson(jsonMap);
          // assert
          expect(result, equals(tError));
        },
      );

      test(
        'should throw ServerFromJsonException when the JSON is invalid error',
        () async {
          // arrange
          final jsonMap = json.decode(fixture('auth_invalid_firebase_error.json')) as Map<String, dynamic>;
          // act
          const call = Error.fromJson;
          // assert
          expect(() => call(jsonMap), throwsA(const TypeMatcher<ServerFromJsonException>()));
        },
      );
    });

    group('toJson -', () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          // act
          final result = tError.toJson();
          // assert
          final expected = {
            'code': 400,
            'message': FirebaseErrors.invalidPassword.value,
          };
          expect(result, expected);
        },
      );
    });
  });

  group('FirebaseErrorModel -', () {
    group('fromJson -', () {
      test(
        'should return a valid model when the JSON ia valid error',
        () async {
          // arrange
          final jsonMap = json.decode(fixture('auth_invalid_password_error.json')) as Map<String, dynamic>;
          // act
          final result = FirebaseErrorModel.fromJson(jsonMap);
          // assert
          expect(result, equals(tFirebaseErrorModel));
        },
      );

      test(
        'should throw ServerFromJsonException when the JSON is invalid error',
        () async {
          // arrange
          final jsonMap = json.decode('{"error":"test error"}') as Map<String, dynamic>;
          // act
          const call = FirebaseErrorModel.fromJson;
          // assert
          expect(() => call(jsonMap), throwsA(const TypeMatcher<ServerFromJsonException>()));
        },
      );
    });

    group('toJson -', () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          // act
          final result = tFirebaseErrorModel.toJson();
          // assert
          final expected = {
            'error': {
              'code': 400,
              'message': FirebaseErrors.invalidPassword.value,
            }
          };
          expect(result, expected);
        },
      );
    });
  });
}
