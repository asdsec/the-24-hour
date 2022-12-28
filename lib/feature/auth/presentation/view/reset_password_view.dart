import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';
import 'package:the_24_hour/product/init/common/page_sized_box.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';
import 'package:the_24_hour/product/widgets/dialog/generic_dialog.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

part '../widgets/reset_password_form.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final loadingWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.resetPasswordView_title.tr()),
      leading: IconButton(
        // TODO(sametdmr): handle hard given splash radius
        splashRadius: 20,
        onPressed: () => navigateBack(context),
        icon: const Icon(Icons.arrow_back_ios_outlined),
      ),
    );
  }

  BlocProvider<ResetPasswordCubit> buildBody() {
    return BlocProvider(
      create: (_) => sl<ResetPasswordCubit>(),
      child: Center(
        child: Padding(
          padding: const PagePadding(),
          child: SingleChildScrollView(
            child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
              listener: listener,
              child: _ResetPasswordForm(),
            ),
          ),
        ),
      ),
    );
  }

  void listener(
    BuildContext context,
    ResetPasswordState state,
  ) {
    state.isLoading ? buildLoadingWidget(context) : dismissLoadingWidget();
    if (state.completed) buildResultDialog(state);
  }

  Future<void> buildResultDialog(ResetPasswordState state) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => GenericDialog(
        title: Center(child: Text(LocaleKeys.resetPasswordView_successDialogTitle.tr())),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.resetPasswordView_successDialogContent.tr()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => navigateToLoginAndRemoveLast(context),
            child: Text(LocaleKeys.button_login.tr()),
          ),
        ],
      ),
    );
  }

  void navigateToLoginAndRemoveLast(BuildContext context) {
    context.router.removeLast();
    context.router.navigate(const LoginRoute());
  }

  Future<void> navigateBack(BuildContext context) async {
    await context.router.pop<void>();
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
