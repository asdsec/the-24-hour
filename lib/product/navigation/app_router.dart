import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/feature/auth/presentation/view/login_view.dart';
import 'package:the_24_hour/feature/auth/presentation/view/loogged_in_view.dart';
import 'package:the_24_hour/feature/auth/presentation/view/reset_password_view.dart';
import 'package:the_24_hour/feature/auth/presentation/view/sign_up_view.dart';
import 'package:the_24_hour/feature/dahboard/presentation/view/dashboard_view.dart';
import 'package:the_24_hour/feature/home/presentation/view/home_view.dart';
import 'package:the_24_hour/feature/settings/presentation/view/settings_view_.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginView, initial: true),
    AutoRoute(page: SignUpView),
    AutoRoute(page: ResetPasswordView),
    AutoRoute(
      page: HomeView,
      children: [
        AutoRoute(page: DashBoardView, initial: true),
        AutoRoute(page: SettingsView),
      ],
    ),
    AutoRoute(page: DummyLoggedInView),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}
