import 'package:auto_route/auto_route.dart';
import 'package:demo/config.dart';
import 'package:demo/router/app_router.dart';
import 'package:flutter/foundation.dart';

class SplashGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (hasSplash &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      router.replace(const Splash()).then((value) => resolver.next(true));
    } else {
      resolver.next(true);
    }
  }
}
