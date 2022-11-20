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
  _$AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final AuthGuard authGuard;

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
    Search.name: (routeData) {
      final args = routeData.argsAs<SearchArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SearchPage(
          query: args.query,
          key: args.key,
        ),
      );
    },
    Language.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LanguagePage(),
      );
    },
    Login.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const LoginPage()),
      );
    },
    Register.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RegisterPage()),
      );
    },
    Splash.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const SplashPage()),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>(
          orElse: () => const ErrorRouteArgs());
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
        child: WrappedRoute(child: const HomePage()),
      );
    },
    Counter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CounterPage()),
      );
    },
    Todos.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TodoPage()),
      );
    },
    My.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MyPage(),
      );
    },
    Setting.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
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
              Todos.name,
              path: 'todos',
              parent: RootRoute.name,
            ),
            RouteConfig(
              My.name,
              path: 'my',
              parent: RootRoute.name,
            ),
            RouteConfig(
              Setting.name,
              path: 'settings-page',
              parent: RootRoute.name,
            ),
          ],
        ),
        RouteConfig(
          LearnFlutterRoute.name,
          path: '/learn-flutter-page',
          guards: [authGuard],
        ),
        RouteConfig(
          Search.name,
          path: '/search',
        ),
        RouteConfig(
          Language.name,
          path: '/language',
        ),
        RouteConfig(
          Login.name,
          path: '/login',
        ),
        RouteConfig(
          Register.name,
          path: '/register',
        ),
        RouteConfig(
          Splash.name,
          path: '/splash-page',
        ),
        RouteConfig(
          ErrorRoute.name,
          path: '*',
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
/// [SearchPage]
class Search extends PageRouteInfo<SearchArgs> {
  Search({
    required String query,
    Key? key,
  }) : super(
          Search.name,
          path: '/search',
          args: SearchArgs(
            query: query,
            key: key,
          ),
        );

  static const String name = 'Search';
}

class SearchArgs {
  const SearchArgs({
    required this.query,
    this.key,
  });

  final String query;

  final Key? key;

  @override
  String toString() {
    return 'SearchArgs{query: $query, key: $key}';
  }
}

/// generated route for
/// [LanguagePage]
class Language extends PageRouteInfo<void> {
  const Language()
      : super(
          Language.name,
          path: '/language',
        );

  static const String name = 'Language';
}

/// generated route for
/// [LoginPage]
class Login extends PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [RegisterPage]
class Register extends PageRouteInfo<void> {
  const Register()
      : super(
          Register.name,
          path: '/register',
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
class ErrorRoute extends PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    Key? key,
    String? error,
  }) : super(
          ErrorRoute.name,
          path: '*',
          args: ErrorRouteArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'ErrorRoute';
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    this.error,
  });

  final Key? key;

  final String? error;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, error: $error}';
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
class Todos extends PageRouteInfo<void> {
  const Todos()
      : super(
          Todos.name,
          path: 'todos',
        );

  static const String name = 'Todos';
}

/// generated route for
/// [MyPage]
class My extends PageRouteInfo<void> {
  const My()
      : super(
          My.name,
          path: 'my',
        );

  static const String name = 'My';
}

/// generated route for
/// [SettingsPage]
class Setting extends PageRouteInfo<void> {
  const Setting()
      : super(
          Setting.name,
          path: 'settings-page',
        );

  static const String name = 'Setting';
}
