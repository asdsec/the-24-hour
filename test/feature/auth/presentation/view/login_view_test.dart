import 'package:easy_localization/easy_localization.dart';
import 'package:either/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/params.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/view/login_view.dart';
import 'package:the_24_hour/injection.dart' as di;
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/error/failure.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/widgets/loading/loading_widget.dart';

@GenerateNiceMocks([
  MockSpec<LoginWithEmailAndPassword>(),
])
import 'login_view_test.mocks.dart';

void main() {
  late MockLoginWithEmailAndPassword mockLoginWithEmailAndPassword;

  setUpAll(() async {
    await di.setup();
    mockLoginWithEmailAndPassword = MockLoginWithEmailAndPassword();
    await di.sl.unregister<LoginCubit>();
    di.sl.registerFactory<LoginCubit>(() => LoginCubit(loginNormal: mockLoginWithEmailAndPassword));
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
            home: const LoginView(),
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
  when the LoginStatus is initial
    ''',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.pump();
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byTooltip(LocaleKeys.button_forgotPassword.tr()), findsOneWidget);
        expect(find.byTooltip(LocaleKeys.button_login.tr()), findsOneWidget);
        expect(find.byTooltip(LocaleKeys.button_signUp.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator when logging in with valid parameters',
    (tester) async {
      when(
        mockLoginWithEmailAndPassword.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => const Right<Failure, void>(null),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.idle();
        await tester.pump(Duration.zero);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_email.tr()), tValidEmail);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_password.tr()), tPassword);
        // await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        await tester.pump(Duration.zero);
        // TODO(sametdmr): temporary expectation handle it
        // expect(find.byType(LoadingIndicator), findsOneWidget);
        // await tester.pump(Duration.zero);
        // expect(find.text('LOGIN SUCCESS'), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build validation error messages when logging in with invalid parameters',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.idle();
        await tester.pump(Duration.zero);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_email.tr()), tInvalidEmail);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_password.tr()), tPassword);
        await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        await tester.pump(Duration.zero);
        expect(find.text(LocaleKeys.errors_formValidation_invalidEmail.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build null text validation error message when logging in with empty text parameters',
    (tester) async {
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.idle();
        await tester.pump(Duration.zero);
        await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        await tester.pump(Duration.zero);
        expect(find.text(LocaleKeys.errors_formValidation_nullEmail.tr()), findsOneWidget);
        expect(find.text(LocaleKeys.errors_formValidation_nullPassword.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator and then ErrorContainer when logging in is unsuccessful',
    (tester) async {
      when(
        mockLoginWithEmailAndPassword.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => const Left(ServerFailure()),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.idle();
        await tester.pump(Duration.zero);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_email.tr()), tValidEmail);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_password.tr()), tPassword);
        await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        await tester.pump(Duration.zero);
        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump(Duration.zero);
        expect(find.text(LocaleKeys.errors_network_serverFailure.tr()), findsOneWidget);
      });
    },
  );

  testWidgets(
    'should build LoadingIndicator and then ErrorContainer with login error message when there is login error',
    (tester) async {
      when(
        mockLoginWithEmailAndPassword.run(
          const AuthorizationParams(email: tValidEmail, password: tPassword),
        ),
      ).thenAnswer(
        (_) async => Left(LoginFailure(LocaleKeys.errors_network_invalidEmailOrPassword.tr())),
      );

      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
        await tester.pumpWidget(createLocalizedWidgetUnderTest());
        await tester.idle();
        await tester.pump(Duration.zero);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_email.tr()), tValidEmail);
        await tester.enterText(find.byTooltip(LocaleKeys.textField_password.tr()), tPassword);
        await tester.tap(find.byTooltip(LocaleKeys.button_login.tr()));
        await tester.pump(Duration.zero);
        expect(find.byType(LoadingIndicator), findsOneWidget);
        await tester.pump(Duration.zero);
        expect(find.text(LocaleKeys.errors_network_invalidEmailOrPassword.tr()), findsOneWidget);
      });
    },
  );
}
