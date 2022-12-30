import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_24_hour/feature/home/presentation/view/home_view.dart';
import 'package:the_24_hour/main.dart' as app;
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login end-to-end test -', () {
    const tEmail = 'login_with_password@integrationtest.com';
    const tPassword = '123456';

    testWidgets(
      'login with email and password',
      (tester) async {
        await app.main();
        await tester.pumpAndSettle();

        final loginButtonFinder = find.byTooltip(LocaleKeys.button_login.tr());
        final emailTextFieldFinder = find.byTooltip(LocaleKeys.textField_email.tr());
        final passwordTextFieldFinder = find.byTooltip(LocaleKeys.textField_password.tr());

        expect(loginButtonFinder, findsOneWidget);
        expect(emailTextFieldFinder, findsOneWidget);
        expect(passwordTextFieldFinder, findsOneWidget);
        expect(find.byTooltip(LocaleKeys.button_forgotPassword.tr()), findsOneWidget);
        expect(find.byTooltip(LocaleKeys.button_signUp.tr()), findsOneWidget);

        await tester.enterText(emailTextFieldFinder, tEmail);
        await tester.enterText(passwordTextFieldFinder, tPassword);
        await tester.tap(loginButtonFinder);

        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(find.byType(HomeView), findsOneWidget);
      },
    );
  });
}
