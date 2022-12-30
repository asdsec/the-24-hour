import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_24_hour/feature/auth/presentation/view/sign_up_view.dart';
import 'package:the_24_hour/feature/home/presentation/view/home_view.dart';
import 'package:the_24_hour/main.dart' as app;
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'utility/delete_account.dart' as integration_test_utility;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async {
    await integration_test_utility.deleteIntegrationTestAccount();
  });

  group('sign up end-to-end test -', () {
    const tEmail = 'sign_up@integrationtest.com';
    const tPassword = '123456';

    testWidgets(
      'sign up with email and password',
      (tester) async {
        await app.main();
        await tester.pumpAndSettle();

        // navigate to sign up page
        final loginButtonFinder = find.byTooltip(LocaleKeys.button_signUp.tr());
        await tester.ensureVisible(loginButtonFinder);
        await tester.tap(loginButtonFinder);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.byType(SignUpView), findsOneWidget);

        // ensure the widgets are in the screen
        final signUpButtonFinder = find.byTooltip(LocaleKeys.button_login.tr());
        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());
        await tester.ensureVisible(signUpButtonFinder);
        await tester.ensureVisible(emailTextFieldFinder);
        await tester.ensureVisible(passwordTextFieldFinder);
        expect(signUpButtonFinder, findsOneWidget);
        expect(emailTextFieldFinder, findsOneWidget);
        expect(passwordTextFieldFinder, findsOneWidget);

        // sign up
        await tester.enterText(emailTextFieldFinder, tEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        await tester.tap(loginButtonFinder);

        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(find.byType(HomeView), findsOneWidget);
      },
    );
  });
}
