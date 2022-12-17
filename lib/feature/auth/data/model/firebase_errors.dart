import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@JsonEnum(valueField: 'value')
enum FirebaseErrors {
  invalidPassword('INVALID_PASSWORD'),
  emailNotFound('EMAIL_NOT_FOUND');

  const FirebaseErrors(this.value);

  final String value;

  bool isLoginError() {
    switch (this) {
      case FirebaseErrors.invalidPassword:
      case FirebaseErrors.emailNotFound:
        return true;
    }
  }

  String get message {
    switch (this) {
      case FirebaseErrors.invalidPassword:
      case FirebaseErrors.emailNotFound:
        return LocaleKeys.errors_network_invalidEmailOrPassword.tr();
    }
  }
}
