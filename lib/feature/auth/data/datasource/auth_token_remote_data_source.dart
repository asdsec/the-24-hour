import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/product/constant/header.dart';
import 'package:the_24_hour/product/enum/network/network_paths.dart';
import 'package:the_24_hour/product/enum/network/network_urls.dart';
import 'package:the_24_hour/product/error/exception.dart';

abstract class AuthTokenRemoteDataSource {
  /// Throws a `ServerException` fro all error codes.
  Future<AuthTokenModel> requestLoginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Throws a `ServerException` fro all error codes.
  Future<AuthTokenModel> requestLoginViaGoogle();
}

class AuthTokenRemoteDataSourceImpl implements AuthTokenRemoteDataSource {
  const AuthTokenRemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<AuthTokenModel> requestLoginViaGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<AuthTokenModel> requestLoginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(NetworkUrls.auth.url + NetworkPaths.signUp.rawValue);
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final response = await client.post(
      url,
      headers: HttpHeader.header,
      body: json.encode(body),
    );

    if (response.statusCode == HttpStatus.ok) {
      return AuthTokenModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
