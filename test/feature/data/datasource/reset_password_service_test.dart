import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/env.dart';
import 'package:the_24_hour/feature/auth/data/datasource/reset_password_service.dart';
import 'package:the_24_hour/product/constant/header.dart';
import 'package:the_24_hour/product/enum/network/network_paths.dart';
import 'package:the_24_hour/product/enum/network/network_urls.dart';
import 'package:the_24_hour/product/error/exception.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'reset_password_service_test.mocks.dart';

void main() {
  late ResetPasswordServiceImpl sut;
  late MockClient mockClient;

  setUpAll(() async {
    await Env.initiate();
  });

  setUp(() {
    mockClient = MockClient();
    sut = ResetPasswordServiceImpl(mockClient);
  });

  group(
    'requestPasswordResetEmail -',
    () {
      const tEmail = 'test email';
      const tBody = {'requestType': 'PASSWORD_RESET', 'email': tEmail};
      final tUrlBase = NetworkUrls.auth.url;
      final tPath = NetworkPaths.sendOobCode.rawValue;

      test(
        'should perform a POST request on a URL with email being the endpoint and with application/json header',
        () async {
          final tUrl = Uri.parse(tUrlBase + tPath + HttpHeader.queryParam);

          // arrange
          when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
            (_) async => http.Response('{}', 200),
          );
          // act
          await sut.requestPasswordResetEmail(tEmail);
          // assert
          verify(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).called(1);
        },
      );

      test(
        'should throw a ServerException when the response status is different from 200',
        () async {
          final tUrl = Uri.parse(tUrlBase + tPath + HttpHeader.queryParam);

          // arrange
          when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
            (_) async => http.Response('{}', 400),
          );
          // act
          final call = sut.requestPasswordResetEmail;
          // assert
          expect(
            () => call(tEmail),
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );

      test(
        'should throw a ServerException when any error occurred',
        () async {
          final tUrl = Uri.parse(tUrlBase + tPath + HttpHeader.queryParam);

          // arrange
          when(mockClient.post(tUrl, headers: HttpHeader.header, body: json.encode(tBody))).thenAnswer(
            (_) async => http.Response('{"error":"Something went wrong!"}', 404),
          );
          // act
          final call = sut.requestPasswordResetEmail;
          // assert
          expect(
            () => call(tEmail),
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );
    },
  );
}
