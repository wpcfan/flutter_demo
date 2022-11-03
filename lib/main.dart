import 'package:auto_route/auto_route.dart';
import 'package:demo/repositories/todo_repository.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/router/guards/auth_guard.dart';
import 'package:demo/states/login_cubit.dart';
import 'package:demo/states/message_cubit.dart';
import 'package:demo/states/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'observers/all.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(
    sharedPreferences: prefs,
  ));
}

class App extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const App({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => TodoRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => MessageCubit()),
            BlocProvider(create: (context) => LoginCubit()),
          ],
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => AppView(),
          ),
        ));
  }
}

class AppView extends StatelessWidget with WidgetsBindingObserver {
  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var brightness = WidgetsBinding.instance.window.platformBrightness;
    // context.read<ThemeCubit>().changeTheme(brightness);
    final AppRouter appRouter =
        AppRouter(AuthGuard(context.read<LoginCubit>()));
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: const [
            ...GlobalMaterialLocalizations.delegates,
            FormBuilderLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
          routerDelegate: AutoRouterDelegate(appRouter,
              navigatorObservers: () => [
                    NavObserver(),
                  ]),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
