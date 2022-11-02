import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/login_cubit.dart';

class AuthGuard extends AutoRouteGuard {
  final LoginCubit loginCubit;
  AuthGuard(this.loginCubit);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (loginCubit.state is LoginSuccess) {
      resolver.next(true);
    } else {
      router.push(const Login()).then((value) {
        resolver.next(false);
      });
    }
  }
}
