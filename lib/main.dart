import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/env.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';

Future<void> main() async {
  final supportedLocales = [Languages.tr.locale, Languages.en.locale];
  const langPath = 'assets/lang';

  await Env.initiate();

  await setup();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: langPath,
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
      title: LocaleKeys.appName.tr(),
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
