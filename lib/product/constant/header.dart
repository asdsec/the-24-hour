import 'package:the_24_hour/env.dart';

class HttpHeader {
  const HttpHeader._();

  static const header = <String, String>{
    'content-type': 'application/json',
  };

  static final queryParam = '?key=${Env.firebaseSecretKey}';
}
