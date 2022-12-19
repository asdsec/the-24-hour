import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/feature/auth/data/model/firebase_error_model.dart';
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
  Future<AuthTokenModel> signUp({
    required String email,
    required String password,
  });
}

class AuthTokenRemoteDataSourceImpl implements AuthTokenRemoteDataSource {
  const AuthTokenRemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<AuthTokenModel> signUp({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      NetworkUrls.auth.url + NetworkPaths.signUp.rawValue + HttpHeader.queryParam,
    );
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    try {
      final response = await client.post(
        url,
        headers: HttpHeader.header,
        body: json.encode(body),
      );

      debugPrint(response.body);

      final data = tryDecode(response.body);

      if (data != null) {
        if (response.statusCode >= HttpStatus.ok && response.statusCode <= HttpStatus.multipleChoices) {
          return AuthTokenModel.fromJson(data);
        } else {
          FirebaseErrorModel.fromJson(data).throwSignInException();
        }
      }

      throw ServerException();
    } on SignUpException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AuthTokenModel> requestLoginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      NetworkUrls.auth.url + NetworkPaths.signInWithPassword.rawValue + HttpHeader.queryParam,
    );
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    try {
      final response = await client.post(
        url,
        headers: HttpHeader.header,
        body: json.encode(body),
      );

      debugPrint(response.body);

      final data = tryDecode(response.body);

      if (data != null) {
        if (response.statusCode >= HttpStatus.ok && response.statusCode <= HttpStatus.multipleChoices) {
          return AuthTokenModel.fromJson(data);
        } else {
          FirebaseErrorModel.fromJson(data).throwLoginException();
        }
      }

      throw ServerException();
    } on LoginException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }

  Map<String, dynamic>? tryDecode(String source) {
    try {
      return json.decode(source) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}
