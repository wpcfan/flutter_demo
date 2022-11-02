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
    RootRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    LearnFlutterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LearnFlutterPage(),
      );
    },
    Login.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    Splash.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    Error.name: (routeData) {
      final args = routeData.argsAs<ErrorArgs>(orElse: () => const ErrorArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ErrorPage(
          key: args.key,
          error: args.error,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          RootRoute.name,
          path: '/',
        ),
        RouteConfig(
          LearnFlutterRoute.name,
          path: '/learn-flutter-page',
        ),
        RouteConfig(
          Login.name,
          path: '/login-page',
        ),
        RouteConfig(
          Splash.name,
          path: '/splash-page',
        ),
        RouteConfig(
          Error.name,
          path: '/error-page',
        ),
      ];
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute()
      : super(
          RootRoute.name,
          path: '/',
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [LearnFlutterPage]
class LearnFlutterRoute extends PageRouteInfo<void> {
  const LearnFlutterRoute()
      : super(
          LearnFlutterRoute.name,
          path: '/learn-flutter-page',
        );

  static const String name = 'LearnFlutterRoute';
}

/// generated route for
/// [LoginPage]
class Login extends PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login-page',
        );

  static const String name = 'Login';
}

/// generated route for
/// [SplashPage]
class Splash extends PageRouteInfo<void> {
  const Splash()
      : super(
          Splash.name,
          path: '/splash-page',
        );

  static const String name = 'Splash';
}

/// generated route for
/// [ErrorPage]
class Error extends PageRouteInfo<ErrorArgs> {
  Error({
    Key? key,
    String? error,
  }) : super(
          Error.name,
          path: '/error-page',
          args: ErrorArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'Error';
}

class ErrorArgs {
  const ErrorArgs({
    this.key,
    this.error,
  });

  final Key? key;

  final String? error;

  @override
  String toString() {
    return 'ErrorArgs{key: $key, error: $error}';
  }
}
