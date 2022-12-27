part of '../view/reset_password_view.dart';

class _ResetPasswordForm extends StatelessWidget {
  _ResetPasswordForm();

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthTextFormField(
            controller: _emailController,
            type: AuthTextFormType.email,
          ),
          const PageSizedBox.withNormalHeight(),
          buildErrorContainerIfNeeded(),
          const PageSizedBox.withNormalHeight(),
          buildSendResetPasswordEmailButton(context),
        ],
      ),
    );
  }

  BlocBuilder<ResetPasswordCubit, ResetPasswordState> buildErrorContainerIfNeeded() {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return state.errorMessage != null
            ? Container(
                padding: const PagePadding(),
                child: Text(state.errorMessage!),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Tooltip buildSendResetPasswordEmailButton(BuildContext context) {
    return Tooltip(
      message: LocaleKeys.button_sendResetPasswordEmail.tr(),
      child: ElevatedButton(
        onPressed: () => sendResetPasswordEmailIfFormValid(context),
        child: Center(child: Text(LocaleKeys.button_sendResetPasswordEmail.tr())),
      ),
    );
  }

  Future<void> sendResetPasswordEmailIfFormValid(BuildContext context) async {
    if (isFormsValid()) {
      await context.read<ResetPasswordCubit>().sendResetPasswordEmail(
            EmailParams(_emailController.text),
          );
    }
  }

  bool isFormsValid() => formKey.currentState?.validate() ?? false;
}
