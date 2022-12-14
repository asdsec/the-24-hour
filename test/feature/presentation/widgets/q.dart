// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:the_24_hour/feature/auth/data/repository/login_repository_impl.dart';
// import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
// import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
// import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';
// import 'package:the_24_hour/feature/auth/presentation/widgets/a.dart';
// import 'package:the_24_hour/injection.dart' as di;
// import 'package:the_24_hour/product/enum/languages.dart';

// @GenerateNiceMocks([
//   MockSpec<LoginCubit>(),
//   MockSpec<LoginState>(),
//   MockSpec<LoginRepositoryImpl>(),
//   MockSpec<LoginWithEmailAndPassword>(),
// ])
// import 'a_test.mocks.dart';

// void main() {
//   late MockLoginCubit mockLoginCubit;
//   late MockLoginState mockLoginState;

//   setUpAll(() async {
//     await di.sl.reset();
//     await di.setup();
//     mockLoginCubit = MockLoginCubit();
//     mockLoginState = MockLoginState();
//     await di.sl.unregister<LoginCubit>();
//     di.sl.registerFactory<LoginCubit>(() => mockLoginCubit);
//   });

//   tearDownAll(() async {
//     await di.sl.reset();
//   });

//   Widget createWidgetUnderTest() {
//     return const MaterialApp(
//       home: ATest(),
//     );
//   }

//   Widget createLocalizedWidgetUnderTest() {
//     final supportedLocales = [Languages.tr.locale, Languages.en.locale];
//     const langPath = 'assets/lang';
//     return EasyLocalization(
//       supportedLocales: supportedLocales,
//       path: langPath,
//       child: Builder(
//         builder: (context) {
//           return MaterialApp(
//             localizationsDelegates: context.localizationDelegates,
//             supportedLocales: context.supportedLocales,
//             locale: context.locale,
//             home: const ATest(),
//           );
//         },
//       ),
//     );
//   }

//   testWidgets('test AT widget', (tester) async {
//     when(mockLoginCubit.state).thenReturn(mockLoginState);
//     when(mockLoginState.status).thenReturn(LoginStatus.initial);

//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pumpAndSettle();
//     expect(find.text('AT'), findsOneWidget);
//   });

//   testWidgets('test TA widget', (tester) async {
//     when(mockLoginCubit.state).thenReturn(mockLoginState);
//     when(mockLoginState.status).thenReturn(LoginStatus.initial);

//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pumpAndSettle();
//     expect(find.text('TA'), findsOneWidget);
//   });

//   testWidgets('test L widget', (tester) async {
//     when(mockLoginCubit.state).thenReturn(mockLoginState);
//     when(mockLoginState.status).thenReturn(LoginStatus.loading);

//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pumpAndSettle();
//     expect(find.text('L'), findsOneWidget);
//   });

//   testWidgets('test UL widget', (tester) async {
//     when(mockLoginCubit.state).thenReturn(mockLoginState);
//     when(mockLoginState.status).thenReturn(LoginStatus.completed);

//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pumpAndSettle();
//     expect(find.text('UL'), findsOneWidget);
//   });

//   testWidgets('test LocaleText widget', (tester) async {
//     when(mockLoginCubit.state).thenReturn(mockLoginState);
//     when(mockLoginState.status).thenReturn(LoginStatus.completed);

//     await tester.runAsync(() async {
//       await EasyLocalization.ensureInitialized();
//       await tester.pumpWidget(createLocalizedWidgetUnderTest());
//       await tester.pumpAndSettle();
//       expect(find.text('24 hour'), findsOneWidget);
//     });
//   });
// }
