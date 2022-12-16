import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/init/mixin/form_validator_mixin.dart';

enum AuthTextFormType { email, password }

class AuthTextFormField extends StatelessWidget with FormValidatorMixin {
  const AuthTextFormField({
    super.key,
    required this.type,
    required this.controller,
  });

  final TextEditingController controller;
  final AuthTextFormType type;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hintText,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: buildIcon,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }

  String get hintText {
    switch (type) {
      case AuthTextFormType.email:
        return LocaleKeys.textField_email.tr();
      case AuthTextFormType.password:
        return LocaleKeys.textField_password.tr();
    }
  }

  Icon get buildIcon {
    switch (type) {
      case AuthTextFormType.email:
        return const Icon(Icons.email_outlined);
      case AuthTextFormType.password:
        return const Icon(Icons.password_outlined);
    }
  }

  String? validator(String? text) {
    switch (type) {
      case AuthTextFormType.email:
        return emailValidator(text);
      case AuthTextFormType.password:
        return passwordValidator(text);
    }
  }
}
