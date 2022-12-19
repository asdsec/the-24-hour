import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

@JsonEnum(valueField: 'value')
enum FirebaseErrors {
  tooManyAttemptsTryLater('TOO_MANY_ATTEMPTS_TRY_LATER'),
  operationNotAllowed('OPERATION_NOT_ALLOWED'),
  emailExists('EMAIL_EXISTS'),
  userDisabled('USER_DISABLED'),
  invalidPassword('INVALID_PASSWORD'),
  emailNotFound('EMAIL_NOT_FOUND');

  const FirebaseErrors(this.value);

  final String value;

  bool isLoginError() {
    switch (this) {
      case FirebaseErrors.invalidPassword:
      case FirebaseErrors.emailNotFound:
        return true;
      case FirebaseErrors.tooManyAttemptsTryLater:
      case FirebaseErrors.operationNotAllowed:
      case FirebaseErrors.emailExists:
      case FirebaseErrors.userDisabled:
        return false;
    }
  }

  bool isSignUpError() {
    switch (this) {
      case FirebaseErrors.emailExists:
        return true;
      case FirebaseErrors.invalidPassword:
      case FirebaseErrors.emailNotFound:
      case FirebaseErrors.tooManyAttemptsTryLater:
      case FirebaseErrors.operationNotAllowed:
      case FirebaseErrors.userDisabled:
        return false;
    }
  }

  String get message {
    switch (this) {
      case FirebaseErrors.invalidPassword:
      case FirebaseErrors.emailNotFound:
        return LocaleKeys.errors_network_invalidEmailOrPassword.tr();
      case FirebaseErrors.tooManyAttemptsTryLater:
      case FirebaseErrors.operationNotAllowed:
      case FirebaseErrors.emailExists:
      case FirebaseErrors.userDisabled:
        return 'email exists';
    }
  }
}
