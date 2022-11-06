import 'package:auto_route/auto_route.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/router/guards/all.dart';
import 'package:demo/states/all.dart';
import 'package:demo/states/register_cubit.dart';
import 'package:demo/widgets/loading_overlay/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'observers/all.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  /// Note: DO NOT put router initialization to builder function
  /// Otherwise you will see empty screen after hot reload
  final AppRouter appRouter = AppRouter(AuthGuard(prefs));
  // final AppRouter appRouter = AppRouter();
  runApp(App(
    sharedPreferences: prefs,
    appRouter: appRouter,
  ));
}

class App extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  // final AppRouter appRouter = AppRouter(AuthGuard(sharedPreferences));
  /// Note: DO NOT put router initialization to builder function
  /// Otherwise you will see empty screen after hot reload
  final AppRouter appRouter;
  const App({
    Key? key,
    required this.sharedPreferences,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => TodoRepository()),
          RepositoryProvider(create: (context) => AuthRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => MessageCubit()),
            BlocProvider<TodoCubit>(
                create: (context) =>
                    TodoCubit(repository: context.read<TodoRepository>())),
            BlocProvider(
                create: (context) =>
                    LoginCubit(repository: context.read<AuthRepository>())),
            BlocProvider(
                create: (context) =>
                    RegisterCubit(repository: context.read<AuthRepository>())),
          ],
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => BlocBuilder<ThemeCubit, ThemeData>(
              builder: (_, theme) {
                return MaterialApp.router(
                  builder: LoadingScreen.init(),
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  localizationsDelegates: const [
                    ...GlobalMaterialLocalizations.delegates,
                    FormBuilderLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  routerDelegate: AutoRouterDelegate(
                    appRouter,
                    navigatorObservers: () => [
                      NavObserver(),
                    ],
                  ),
                  routeInformationParser: appRouter.defaultRouteParser(),
                );
              },
            ),
          ),
        ));
  }
}
