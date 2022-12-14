import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:the_24_hour/feature/auth/presentation/view/login_view.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(initial: true, page: LoginView),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}