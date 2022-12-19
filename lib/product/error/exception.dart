// Network

import 'package:flutter/foundation.dart';

class ServerException implements Exception {}

class ServerFromJsonException implements Exception {}

class NullFieldServerException implements Exception {}

@immutable
class LoginException implements Exception {
  const LoginException(this.errorMessage);

  final String errorMessage;
}

@immutable
class SignUpException implements Exception {
  const SignUpException(this.errorMessage);

  final String errorMessage;
}

// Cache

class ClosedBoxException implements Exception {}

class NullBoxModelException implements Exception {}

class UnregisteredHiveAdapterException implements Exception {}

// Core

class UninitiatedEnvironmentVariable implements Exception {}
