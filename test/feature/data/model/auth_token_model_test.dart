import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/feature/auth/domain/entity/auth_token.dart';
import 'package:the_24_hour/product/error/exception.dart';

import '../../../fixture/fixture_reader.dart';

void main() {
  const tAuthTokenModel = AuthTokenModel(
    localId: 'test localId',
    email: 'test email',
    idToken: 'test idToken',
    refreshToken: 'test refreshToken',
    expiresIn: 3600,
  );

  test(
    'should be a subclass of AuthToken entity',
    () async {
      // assert
      expect(tAuthTokenModel, isA<AuthToken>());
    },
  );

  group('fromJson -', () {
    test(
      'should return a valid model when the JSON expiresIn regarded as int and others regarded as String',
      () async {
        // arrange
        final jsonMap = json.decode(fixture('auth_token_int_expire.json')) as Map<String, dynamic>;
        // act
        final result = AuthTokenModel.fromJson(jsonMap);
        // assert
        expect(result, equals(tAuthTokenModel));
      },
    );

    test(
      'should return a valid model when the all elements of JSON regarded as String',
      () async {
        // arrange
        final jsonMap = json.decode(fixture('auth_token.json')) as Map<String, dynamic>;
        // act
        final result = AuthTokenModel.fromJson(jsonMap);
        // assert
        expect(result, tAuthTokenModel);
      },
    );

    test(
      'should throw NullFieldServerException when an elements of JSON regarded as null',
      () async {
        // arrange
        final jsonMap = json.decode(fixture('auth_token_null.json')) as Map<String, dynamic>;
        // act
        const call = AuthTokenModel.fromJson;
        // assert
        expect(() => call(jsonMap), throwsA(const TypeMatcher<NullFieldServerException>()));
      },
    );

    test(
      'should throw ServerFromJsonException when the JSON expiresIn regarded as invalid integer String',
      () async {
        // arrange
        final jsonMap = json.decode(fixture('auth_token_invalid_int_str.json')) as Map<String, dynamic>;
        // act
        const call = AuthTokenModel.fromJson;
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
        final result = tAuthTokenModel.toJson();
        // assert
        final expected = {
          'localId': 'test localId',
          'email': 'test email',
          'idToken': 'test idToken',
          'refreshToken': 'test refreshToken',
          'expiresIn': '3600',
        };
        expect(result, expected);
      },
    );
  });
}
