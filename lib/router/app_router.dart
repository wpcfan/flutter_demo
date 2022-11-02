import 'package:auto_route/auto_route.dart';
import 'package:demo/pages/all.dart';
import 'package:demo/pages/my_page.dart';
import 'package:demo/pages/register_page.dart';
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
        AutoRoute(page: TodoPage, name: 'todo'),
        AutoRoute(page: MyPage, name: 'my'),
      ],
      guards: [AuthGuard],
    ),
    AutoRoute(page: LearnFlutterPage),
    AutoRoute(page: LoginPage, name: 'login'),
    AutoRoute(page: RegisterPage, name: 'register'),
    AutoRoute(page: SplashPage, name: 'splash'),
    AutoRoute(page: ErrorPage, name: 'error'),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  AppRouter(AuthGuard authGuard) : super(authGuard: authGuard);
}
