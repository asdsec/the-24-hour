import 'package:easy_localization/easy_localization.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

mixin FormValidatorMixin {
  String? emailValidator(String? email) {
    const source =
        r'^(([^<>()[\]\\.,:\s@\"]+(.[^<>()[]\\.,;:s@\"]+)*)|(\".+\"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(source);

    if (email != null && email.isNotEmpty) {
      final isValid = regex.hasMatch(email);
      return isValid ? null : LocaleKeys.errors_formValidation_invalidEmail.tr();
    } else {
      return LocaleKeys.errors_formValidation_nullEmail.tr();
    }
  }

  String? passwordValidator(String? password) {
    if (password != null && password.isNotEmpty) {
      return password.length >= 6 ? null : LocaleKeys.errors_formValidation_shortPassword.tr();
    } else {
      return LocaleKeys.errors_formValidation_nullPassword.tr();
    }
  }
}
