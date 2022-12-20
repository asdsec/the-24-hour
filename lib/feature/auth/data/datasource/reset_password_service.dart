import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:the_24_hour/product/constant/header.dart';
import 'package:the_24_hour/product/enum/network/network_paths.dart';
import 'package:the_24_hour/product/enum/network/network_urls.dart';
import 'package:the_24_hour/product/error/exception.dart';

mixin ResetPasswordService {
  Future<void> requestPasswordResetEmail(String email);
}

class ResetPasswordServiceImpl implements ResetPasswordService {
  const ResetPasswordServiceImpl(this.client);

  final http.Client client;

  @override
  Future<void> requestPasswordResetEmail(String email) async {
    final url = Uri.parse(
      NetworkUrls.auth.url + NetworkPaths.sendOobCode.rawValue + HttpHeader.queryParam,
    );
    final body = {'requestType': 'PASSWORD_RESET', 'email': email};

    try {
      final response = await client.post(
        url,
        body: json.encode(body),
        headers: HttpHeader.header,
      );
      if (response.statusCode != HttpStatus.ok) throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
