import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/view/login_view.dart';
import 'package:the_24_hour/injection.dart' as di;
import 'package:the_24_hour/product/enum/languages.dart';

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
        expect(find.byIcon(Icons.email_outlined), findsOneWidget);
        expect(find.byIcon(Icons.password_outlined), findsOneWidget);
        expect(find.byKey(const Key('login-button')), findsOneWidget);
      });
    },
  );
}
