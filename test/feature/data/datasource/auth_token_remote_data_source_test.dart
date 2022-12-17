import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_remote_data_source.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/product/constant/header.dart';
import 'package:the_24_hour/product/enum/network/network_paths.dart';
import 'package:the_24_hour/product/enum/network/network_urls.dart';
import 'package:the_24_hour/product/error/exception.dart';

import '../../../fixture/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'auth_token_remote_data_source_test.mocks.dart';

void main() {
  late AuthTokenRemoteDataSourceImpl sut;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    sut = AuthTokenRemoteDataSourceImpl(mockClient);
  });

  group('requestLoginWithEmailAndPassword -', () {
    const tEmail = 'test email';
    const tPassword = 'test password';
    const tBody = {
      'email': tEmail,
      'password': tPassword,
      'returnSecureToken': true,
    };
    final tUrlBase = NetworkUrls.auth.url;
    final tPath = NetworkPaths.signInWithPassword.rawValue;
    final tUrl = Uri.parse(tUrlBase + tPath + HttpHeader.queryParam);
    final tAuthTokenModel = AuthTokenModel.fromJson(
      json.decode(fixture('auth_token.json')) as Map<String, dynamic>,
    );

    test(
      'should perform a POST request on a URL with email and password being the endpoint and with application/json header',
      () async {
        // arrange
        when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
          (_) async => http.Response(fixture('auth_token.json'), 200),
        );
        // act
        await sut.requestLoginWithEmailAndPassword(email: tEmail, password: tPassword);
        // assert
        verify(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).called(1);
      },
    );

    test(
      'should return AuthTokenModel when the response code is (success)',
      () async {
        // arrange
        when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
          (_) async => http.Response(fixture('auth_token.json'), 200),
        );
        // act
        final result = await sut.requestLoginWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        expect(result, equals(tAuthTokenModel));
      },
    );

    test(
      'should throw a LoginException when the response has the error of EMAIL_NOT_FOUND',
      () async {
        // arrange
        when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
          (_) async => http.Response(fixture('auth_email_not_found_error.json'), 400),
        );
        // act
        final call = sut.requestLoginWithEmailAndPassword;
        // assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(const TypeMatcher<LoginException>()),
        );
      },
    );

    test(
      'should throw a LoginException when the response has the error of INVALID_PASSWORD',
      () async {
        // arrange
        when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
          (_) async => http.Response(fixture('auth_invalid_password_error.json'), 400),
        );
        // act
        final call = sut.requestLoginWithEmailAndPassword;
        // assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(const TypeMatcher<LoginException>()),
        );
      },
    );

    test(
      'should throw a ServerException when any error occurred except EMAIL_NOT_FOUND, INVALID_PASSWORD',
      () async {
        // arrange
        when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
          (_) async => http.Response('{"error":"Something went wrong!"}', 404),
        );
        // act
        final call = sut.requestLoginWithEmailAndPassword;
        // assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
