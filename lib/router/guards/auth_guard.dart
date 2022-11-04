import 'package:auto_route/auto_route.dart';
import 'package:demo/config.dart';
import 'package:demo/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  final SharedPreferences perfs;
  AuthGuard(this.perfs);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (perfs.getString('sessionToken') != null) {
      resolver.next(true);
    } else {
      if (restoreLastRouteBeforeLogin) {
        debugPrint('AuthGuard: current route -- ${router.currentPath}');
        perfs.setString(PERF_KEY_ROUTE_BEFORE_LOGIN, router.currentPath);
      }
      router.push(const Login()).then((value) {
        resolver.next(false);
      });
    }
  }
}
