import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/env.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';
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
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.lime.withOpacity(.7),
          onPrimary: Colors.white.withOpacity(.8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
          contentPadding: const WidgetPadding.formField(),
          hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.5),
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const WidgetPadding.button(),
            shape: const StadiumBorder(),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const WidgetPadding.button(),
            shape: StadiumBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: const StadiumBorder(),
          ),
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
