part of '../view/login_view.dart';

class _LoginForm extends StatelessWidget {
  _LoginForm() : super();

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
          buildForgotPasswordButton(),
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

  BlocBuilder<LoginCubit, LoginState> buildErrorContainerIfNeeded() {
    return BlocBuilder<LoginCubit, LoginState>(
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

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Tooltip(
        message: LocaleKeys.button_forgotPassword.tr(),
        child: TextButton(
          onPressed: () {},
          child: Text(LocaleKeys.button_forgotPassword.tr()),
        ),
      ),
    );
  }

  Tooltip buildLoginButton(BuildContext context) {
    return Tooltip(
      message: LocaleKeys.button_login.tr(),
      child: ElevatedButton(
        onPressed: () => loginWithEmailAndPasswordIfFormValid(context),
        child: Center(child: Text(LocaleKeys.button_login.tr())),
      ),
    );
  }

  Future<void> loginWithEmailAndPasswordIfFormValid(BuildContext context) async {
    context.read<LoginCubit>().clearState();
    if (isFormsValid()) {
      await context.read<LoginCubit>().loginWithEmailAndPassword(
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
      message: LocaleKeys.button_signUp.tr(),
      child: OutlinedButton(
        onPressed: () => context.router.navigate(const SignUpRoute()),
        child: Center(child: Text(LocaleKeys.button_signUp.tr())),
      ),
    );
  }
}
