// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignUpView(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ResetPasswordView(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    DummyLoggedInRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DummyLoggedInView(),
      );
    },
    DashBoardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DashBoardView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingsView(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          LoginRoute.name,
          path: '/',
        ),
        RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-view',
        ),
        RouteConfig(
          ResetPasswordRoute.name,
          path: '/reset-password-view',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home-view',
          children: [
            RouteConfig(
              DashBoardRoute.name,
              path: '',
              parent: HomeRoute.name,
            ),
            RouteConfig(
              SettingsRoute.name,
              path: 'settings-view',
              parent: HomeRoute.name,
            ),
          ],
        ),
        RouteConfig(
          DummyLoggedInRoute.name,
          path: '/dummy-logged-in-view',
        ),
      ];
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-view',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [ResetPasswordView]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute()
      : super(
          ResetPasswordRoute.name,
          path: '/reset-password-view',
        );

  static const String name = 'ResetPasswordRoute';
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/home-view',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [DummyLoggedInView]
class DummyLoggedInRoute extends PageRouteInfo<void> {
  const DummyLoggedInRoute()
      : super(
          DummyLoggedInRoute.name,
          path: '/dummy-logged-in-view',
        );

  static const String name = 'DummyLoggedInRoute';
}

/// generated route for
/// [DashBoardView]
class DashBoardRoute extends PageRouteInfo<void> {
  const DashBoardRoute()
      : super(
          DashBoardRoute.name,
          path: '',
        );

  static const String name = 'DashBoardRoute';
}

/// generated route for
/// [SettingsView]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings-view',
        );

  static const String name = 'SettingsRoute';
}
