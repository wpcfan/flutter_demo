import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('didPush: $route');
    super.didPush(route, previousRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    debugPrint('didInitTabRoute: $route');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    debugPrint('didChangeTabRoute: $route');
    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('didPop: $route');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint('didRemove: $route');
    super.didRemove(route, previousRoute);
  }
}
