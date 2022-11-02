import 'package:auto_route/auto_route.dart';
import 'package:demo/pages/all.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: RootPage, initial: true),
    AutoRoute(page: LearnFlutterPage),
    AutoRoute(page: LoginPage, name: 'login'),
    AutoRoute(page: SplashPage, name: 'splash'),
    AutoRoute(page: ErrorPage, name: 'error'),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
