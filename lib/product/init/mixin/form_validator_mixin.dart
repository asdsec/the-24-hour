mixin FormValidatorMixin {
  String? emailValidator(String? email) {
    const source =
        r'^(([^<>()[\]\\.,:\s@\"]+(.[^<>()[]\\.,;:s@\"]+)*)|(\".+\"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(source);

    // TODO(sametdmr): write them in language files
    const invalidEmailMessage = 'Invalid Email!';
    const emailCannotBeNullMessage = 'Email cannot be null!';

    if (email != null && email.isNotEmpty) {
      final isValid = regex.hasMatch(email);
      return isValid ? null : invalidEmailMessage;
    } else {
      return emailCannotBeNullMessage;
    }
  }

  String? passwordValidator(String? password) {
    // TODO(sametdmr): write them in language files
    const shortPasswordMessage = 'Password should include at least 6 characters!';
    const passwordCannotBeNullMessage = 'Password cannot be null!';

    if (password != null && password.isNotEmpty) {
      return password.length >= 6 ? null : shortPasswordMessage;
    } else {
      return passwordCannotBeNullMessage;
    }
  }
}
