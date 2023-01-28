import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/env.dart';
import 'package:the_24_hour/firebase_options.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/enum/languages.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';

Future<void> main() async {
  final supportedLocales = [Languages.tr.locale, Languages.en.locale];
  const langPath = 'assets/lang';

  await Env.initiate();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setup();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: langPath,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.lime.withOpacity(.7),
          onPrimary: Colors.white.withOpacity(.8),
          error: const Color(0xffff453a),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
          contentPadding: const WidgetPadding.formField(),
          hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
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
              side: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: const StadiumBorder(),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      title: LocaleKeys.appName.tr(),
      debugShowCheckedModeBanner: false,
      routerDelegate: sl.get<AppRouter>().delegate(),
      routeInformationParser: sl.get<AppRouter>().defaultRouteParser(),
      routeInformationProvider: sl.get<AppRouter>().routeInfoProvider(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
