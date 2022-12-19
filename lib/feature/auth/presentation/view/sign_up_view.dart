import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_state.dart';
import 'package:the_24_hour/feature/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';
import 'package:the_24_hour/product/init/common/page_sized_box.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

part '../widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final loadingWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  BlocProvider<SignUpCubit> buildBody() {
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: Center(
        child: Padding(
          padding: const PagePadding(),
          child: SingleChildScrollView(
            child: BlocListener<SignUpCubit, SignUpState>(
              listener: listener,
              child: _SignUpForm(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> listener(BuildContext context, SignUpState state) async {
    await buildLoadingWidgetWhenNeeded(context, state);
    // ignore: use_build_context_synchronously
    await navigateToHome(context, state);
  }

  Future<void> buildLoadingWidgetWhenNeeded(
    BuildContext context,
    SignUpState state,
  ) async {
    state.status == SignUpStatus.loading ? buildLoadingWidget(context) : dismissLoadingWidget();
  }

  Future<void> navigateToHome(BuildContext context, SignUpState state) async {
    if (state.status == SignUpStatus.completed) {
      await context.router.replace(const DummyLoggedInRoute());
    }
  }

  Future<void> buildLoadingWidget(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingIndicator(key: loadingWidgetKey),
    );
  }

  void dismissLoadingWidget() => loadingWidgetKey.currentContext?.pop();
}
