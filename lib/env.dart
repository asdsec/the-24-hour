// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_24_hour/product/error/exception.dart';

enum _Variables {
  FIREBASE_SECRET_KEY,
}

class Env {
  static final String firebaseSecretKey = dotenv.get(_Variables.FIREBASE_SECRET_KEY.name);

  /// Throws `UninitiatedEnvironmentVariable` if every environment variable is not initiated
  static Future<void> initiate() async {
    await dotenv.load(fileName: _fileName);
    if (!dotenv.isEveryDefined(_Variables.values.map((value) => value.name))) {
      throw UninitiatedEnvironmentVariable();
    }
  }

  static String get _fileName {
    if (kReleaseMode) return '.env.production';
    return '.env.dev';
  }
}
