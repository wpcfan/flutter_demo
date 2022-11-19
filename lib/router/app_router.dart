import 'package:auto_route/auto_route.dart';
import 'package:demo/pages/all.dart';
import 'package:demo/router/guards/auth_guard.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: RootPage,
      initial: true,
      children: [
        AutoRoute(page: HomePage, name: 'home', initial: true),
        AutoRoute(page: CounterPage, name: 'counter'),
        AutoRoute(page: TodoPage, name: 'todos', path: 'todos'),
        AutoRoute(page: MyPage, name: 'my', path: 'my'),
        AutoRoute(page: SettingsPage, name: 'setting'),
      ],
    ),
    AutoRoute(
      page: LearnFlutterPage,
      guards: [AuthGuard],
    ),
    AutoRoute(page: LanguagePage, name: 'language', path: '/language'),
    AutoRoute(page: LoginPage, name: 'login', path: '/login'),
    AutoRoute(page: RegisterPage, name: 'register', path: '/register'),
    AutoRoute(page: SplashPage, name: 'splash'),
    AutoRoute(page: ErrorPage, path: '*'),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  AppRouter(AuthGuard authGuard) : super(authGuard: authGuard);
}
