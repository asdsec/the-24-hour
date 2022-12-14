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
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const PageSizedBox.withNormalHeight(),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
          const PageSizedBox.withNormalHeight(),
          buildErrorContainerIfNeeded(),
          const PageSizedBox.withNormalHeight(),
          ElevatedButton(
            key: const Key('login-button'),
            onPressed: () => loginWithEmailAndPasswordIfFormValid(context),
            child: Center(child: Text(LocaleKeys.button_login.tr())),
          ),
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

  Future<void> loginWithEmailAndPasswordIfFormValid(BuildContext context) async {
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
}
