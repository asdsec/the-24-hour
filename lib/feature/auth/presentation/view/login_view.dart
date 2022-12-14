import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';
import 'package:the_24_hour/product/init/common/page_sized_box.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

part '../widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loadingWidgetKey = GlobalKey(debugLabel: 'loadingIndicator');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  BlocProvider<LoginCubit> buildBody() {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: Center(
        child: Padding(
          padding: const PagePadding(),
          child: SingleChildScrollView(
            child: BlocListener<LoginCubit, LoginState>(
              listener: buildLoadingWidgetWhenNeeded,
              child: _LoginForm(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> buildLoadingWidgetWhenNeeded(
    BuildContext context,
    LoginState state,
  ) async {
    state.status == LoginStatus.loading ? buildLoadingWidget() : dismissLoadingWidget();
  }

  Future<void> buildLoadingWidget() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingIndicator(key: loadingWidgetKey),
    );
  }

  void dismissLoadingWidget() => loadingWidgetKey.currentContext?.pop();
}
