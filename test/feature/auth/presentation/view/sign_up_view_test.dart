import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/sign_up.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/view/sign_up_view.dart';
import 'package:the_24_hour/injection.dart' as di;
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

@GenerateNiceMocks([
  MockSpec<SignUp>(),
])
import 'sign_up_view_test.mocks.dart';

void main() {
  late MockSignUp mockSignUp;

  setUpAll(() async {
    await di.setup();
    mockSignUp = MockSignUp();
    await di.sl.unregister<SignUpCubit>();
    di.sl.registerFactory<SignUpCubit>(() => SignUpCubit(signUp: mockSignUp));
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
            home: const SignUpView(),
          );
        },
      ),
    );
  }

  const tValidEmail = 'test@test.com';
  const tPassword = 'test password';
  const tInvalidEmail = 'test invalid email';

  testWidgets(
    '''
should include two TextFormField and one Elevated Button
  when the SignUpStatus is initial
    ''',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump();
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byTooltip(LocaleKeys.button_login.tr()), findsOneWidget);
        expect(find.byTooltip(LocaleKeys.button_signUp.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator when signing up with valid parameters',
    (tester) async {
      when(
        mockSignUp.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => const Right<Failure, void>(null),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());
        await tester.ensureVisible(emailTextFieldFinder);
        await tester.ensureVisible(passwordTextFieldFinder);
        await tester.enterText(emailTextFieldFinder, tValidEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        // await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        // await tester.pump(Duration.zero);
        // TODO(sametdmr): temporary expectation handle it
        // expect(find.byType(LoadingIndicator), findsOneWidget);
        // await tester.pump(Duration.zero);
        // expect(find.text('LOGIN SUCCESS'), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build validation error messages when signing up with invalid parameters',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());
        final signUpButtonFinder = find.byTooltip(LocaleKeys.button_signUp.tr());
        await tester.ensureVisible(emailTextFieldFinder);
        await tester.ensureVisible(passwordTextFieldFinder);
        await tester.ensureVisible(signUpButtonFinder);
        await tester.enterText(emailTextFieldFinder, tInvalidEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        await tester.tap(signUpButtonFinder);
        await tester.pump(Duration.zero);

        expect(find.text(LocaleKeys.errors_formValidation_invalidEmail.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build null text validation error message when signing up with empty text parameters',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final signUpButtonFinder = find.byTooltip(LocaleKeys.button_signUp.tr());
        await tester.ensureVisible(signUpButtonFinder);
        await tester.tap(signUpButtonFinder);
        await tester.pump(Duration.zero);

        expect(find.text(LocaleKeys.errors_formValidation_nullEmail.tr()), findsOneWidget);
        expect(find.text(LocaleKeys.errors_formValidation_nullPassword.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator and then ErrorContainer when signing up is unsuccessful',
    (tester) async {
      when(
        mockSignUp.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => const Left(ServerFailure()),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());
        final signUpButtonFinder = find.byTooltip(LocaleKeys.button_signUp.tr());
        await tester.ensureVisible(emailTextFieldFinder);
        await tester.ensureVisible(passwordTextFieldFinder);
        await tester.ensureVisible(signUpButtonFinder);
        await tester.enterText(emailTextFieldFinder, tValidEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        await tester.tap(signUpButtonFinder);
        await tester.pump(Duration.zero);

        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump(Duration.zero);

        expect(find.text(LocaleKeys.errors_network_serverFailure.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator and then ErrorContainer with sign up error message when there is sign up error',
    (tester) async {
      when(
        mockSignUp.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => Left(SignUpFailure(LocaleKeys.errors_network_emailExists.tr())),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump(Duration.zero);

        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());
        final signUpButtonFinder = find.byTooltip(LocaleKeys.button_signUp.tr());
        await tester.ensureVisible(emailTextFieldFinder);
        await tester.ensureVisible(passwordTextFieldFinder);
        await tester.ensureVisible(signUpButtonFinder);
        await tester.enterText(emailTextFieldFinder, tValidEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        await tester.tap(signUpButtonFinder);
        await tester.pump(Duration.zero);

        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump(Duration.zero);

        expect(find.text(LocaleKeys.errors_network_emailExists.tr()), findsOneWidget);
      });
    },
  );
}
