import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/reset_password.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/view/reset_password_view.dart';
import 'package:the_24_hour/feature/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:the_24_hour/injection.dart' as di;
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/widgets/dialog/generic_dialog.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

@GenerateNiceMocks([MockSpec<ResetPassword>()])
import 'reset_password_view_test.mocks.dart';

void main() {
  late MockResetPassword mockResetPassword;

  setUpAll(() async {
    await di.setup();
    mockResetPassword = MockResetPassword();
    await di.sl.unregister<ResetPasswordCubit>();
    di.sl.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(mockResetPassword));
  });

  tearDownAll(() async {
    await di.sl.reset();
  });

  Widget createLocalizedWidgetUnderTest() {
    final supportedLocales = [Languages.tr.locale, Languages.en.locale];
    const langPath = 'assets/lang';
    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: langPath,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const ResetPasswordView(),
          );
        },
      ),
    );
  }

  const tValidEmail = 'test@test.com';
  const tInvalidEmail = 'test invalid email';

  testWidgets(
    '''
should include (backButton on AppBar), (email text field), (sendResetPasswordButton)
when ResetPasswordState is [ResetPasswordState.initial()]
    ''',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final backButtonFinder = find.byIcon(Icons.arrow_back_ios_outlined);
        final emailFormFieldFinder = find.byType(AuthTextFormField);
        final sendResetEmailButtonFinder = find.byTooltip(LocaleKeys.button_sendResetPasswordEmail.tr());
        await tester.ensureVisible(backButtonFinder);
        await tester.ensureVisible(emailFormFieldFinder);
        await tester.ensureVisible(sendResetEmailButtonFinder);
        expect(backButtonFinder, findsOneWidget);
        expect(emailFormFieldFinder, findsOneWidget);
        expect(sendResetEmailButtonFinder, findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build process succeeded dialog when the use case successful',
    (tester) async {
      when(mockResetPassword.run(const EmailParams(tValidEmail))).thenAnswer(
        (_) async => const Right(null),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final emailFormFieldFinder = find.byType(AuthTextFormField);
        final sendResetEmailButtonFinder = find.byTooltip(LocaleKeys.button_sendResetPasswordEmail.tr());
        await tester.ensureVisible(emailFormFieldFinder);
        await tester.ensureVisible(sendResetEmailButtonFinder);
        await tester.enterText(emailFormFieldFinder, tValidEmail);
        await tester.tap(sendResetEmailButtonFinder);
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump();

        expect(find.byType(GenericDialog), findsOneWidget);
        expect(find.text(LocaleKeys.resetPasswordView_successDialogTitle.tr()), findsOneWidget);
        expect(find.text(LocaleKeys.resetPasswordView_successDialogContent.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build invalid email validator error when the email is invalid',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump();

        final emailFormFieldFinder = find.byType(AuthTextFormField);
        final sendResetEmailButtonFinder = find.byTooltip(LocaleKeys.button_sendResetPasswordEmail.tr());
        await tester.ensureVisible(emailFormFieldFinder);
        await tester.ensureVisible(sendResetEmailButtonFinder);
        await tester.enterText(emailFormFieldFinder, tInvalidEmail);
        await tester.tap(sendResetEmailButtonFinder);
        await tester.pump();

        expect(find.text(LocaleKeys.errors_formValidation_invalidEmail.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build ErrorContainer with ServerFailure error message when the use case is not successful',
    (tester) async {
      when(mockResetPassword.run(const EmailParams(tValidEmail))).thenAnswer(
        (_) async => const Left(ServerFailure()),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump();

        final emailFormFieldFinder = find.byType(AuthTextFormField);
        final sendResetEmailButtonFinder = find.byTooltip(LocaleKeys.button_sendResetPasswordEmail.tr());
        await tester.ensureVisible(emailFormFieldFinder);
        await tester.ensureVisible(sendResetEmailButtonFinder);
        await tester.enterText(emailFormFieldFinder, tValidEmail);
        await tester.tap(sendResetEmailButtonFinder);
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump();

        expect(find.text(LocaleKeys.errors_network_serverFailure.tr()), findsOneWidget);
      });
    },
  );
}
