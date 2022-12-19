import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:the_24_hour/env.dart';
import 'package:the_24_hour/product/constant/header.dart';
import 'package:the_24_hour/product/enum/network/network_paths.dart';
import 'package:the_24_hour/product/enum/network/network_urls.dart';

Future<void> deleteIntegrationTestAccount() async {
  // necessary for HttpHeader.queryParam
  await Env.initiate();

  const bodyForSignIn = {
    'email': 'sign_up@integrationtest.com',
    'password': '123456',
    'returnSecureToken': true,
  };
  final signInEndPoint = Uri.parse(
    NetworkUrls.auth.url + NetworkPaths.signInWithPassword.rawValue + HttpHeader.queryParam,
  );
  final deleteAccountEndPoint = Uri.parse(
    NetworkUrls.auth.url + NetworkPaths.delete.rawValue + HttpHeader.queryParam,
  );

  try {
    final response = await http.post(
      signInEndPoint,
      headers: HttpHeader.header,
      body: json.encode(bodyForSignIn),
    );

    final loginData = json.decode(response.body) as Map<String, dynamic>;
    final bodyForDeleteAccount = {'idToken': loginData['idToken']};
    final result = await http.post(
      deleteAccountEndPoint,
      headers: HttpHeader.header,
      body: json.encode(bodyForDeleteAccount),
    );

    if (result.statusCode == HttpStatus.ok) {
      debugPrint('[INTEGRATION TEST INFO] : Account deletion successful');
    }
  } catch (e) {
    debugPrint('[ERROR] : deleteIntegrationTestAccount error');
    debugPrint(e.toString());
  }
}
