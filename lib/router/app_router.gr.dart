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
    Register.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
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
    Home.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    Counter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CounterPage(),
      );
    },
    Todo.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TodoPage(),
      );
    },
    My.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MyPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          RootRoute.name,
          path: '/',
          children: [
            RouteConfig(
              Home.name,
              path: '',
              parent: RootRoute.name,
            ),
            RouteConfig(
              Counter.name,
              path: 'counter-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              Todo.name,
              path: 'todo-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              My.name,
              path: 'my-page',
              parent: RootRoute.name,
            ),
          ],
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
          Register.name,
          path: '/register-page',
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
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          path: '/',
          initialChildren: children,
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
/// [RegisterPage]
class Register extends PageRouteInfo<void> {
  const Register()
      : super(
          Register.name,
          path: '/register-page',
        );

  static const String name = 'Register';
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

/// generated route for
/// [HomePage]
class Home extends PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '',
        );

  static const String name = 'Home';
}

/// generated route for
/// [CounterPage]
class Counter extends PageRouteInfo<void> {
  const Counter()
      : super(
          Counter.name,
          path: 'counter-page',
        );

  static const String name = 'Counter';
}

/// generated route for
/// [TodoPage]
class Todo extends PageRouteInfo<void> {
  const Todo()
      : super(
          Todo.name,
          path: 'todo-page',
        );

  static const String name = 'Todo';
}

/// generated route for
/// [MyPage]
class My extends PageRouteInfo<void> {
  const My()
      : super(
          My.name,
          path: 'my-page',
        );

  static const String name = 'My';
}
