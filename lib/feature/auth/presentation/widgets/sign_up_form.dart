part of '../view/sign_up_view.dart';

class _SignUpForm extends StatelessWidget {
  _SignUpForm() : super();

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          AuthTextFormField(
            controller: _passwordController,
            type: AuthTextFormType.password,
          ),
          const PageSizedBox.withNormalHeight(),
          buildErrorContainerIfNeeded(),
          const PageSizedBox.withNormalHeight(),
          buildLoginButton(context),
          const PageSizedBox.withNormalHeight(),
          buildSignUpButton(context),
        ],
      ),
    );
  }

  BlocBuilder<SignUpCubit, SignUpState> buildErrorContainerIfNeeded() {
    return BlocBuilder<SignUpCubit, SignUpState>(
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

  Tooltip buildLoginButton(BuildContext context) {
    return Tooltip(
      message: LocaleKeys.button_signUp.tr(),
      child: ElevatedButton(
        onPressed: () => signUpWithPassword(context),
        child: Center(child: Text(LocaleKeys.button_signUp.tr())),
      ),
    );
  }

  Future<void> signUpWithPassword(BuildContext context) async {
    context.read<SignUpCubit>().clearState();
    if (isFormsValid()) {
      await context.read<SignUpCubit>().signUpWithPassword(
            AuthorizationParams(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  bool isFormsValid() => formKey.currentState?.validate() ?? false;

  Tooltip buildSignUpButton(BuildContext context) {
    return Tooltip(
      message: LocaleKeys.button_login.tr(),
      child: OutlinedButton(
        onPressed: () => context.router.navigate(const LoginRoute()),
        child: Center(child: Text(LocaleKeys.button_login.tr())),
      ),
    );
  }
}
