part of 'main.dart';

class App extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final AppRouter appRouter;
  const App({
    Key? key,
    required this.sharedPreferences,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositoryProviders,
      child: MultiBlocProvider(
        providers: buildProviders,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) => BlocBuilder<ThemeCubit, ThemeData>(
            builder: (_, theme) {
              return MaterialApp.router(
                builder: LoadingScreen.init(),
                debugShowCheckedModeBanner: false,
                theme: theme,
                localizationsDelegates: buildLocalizationDelegates,
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
      ),
    );
  }

  /// 本地化
  List<LocalizationsDelegate<dynamic>> get buildLocalizationDelegates {
    return [
      ...GlobalMaterialLocalizations.delegates,
      FormBuilderLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }

  /// 注册 Bloc 依赖
  List<BlocProviderSingleChildWidget> get buildProviders {
    return [
      BlocProvider(create: (context) => ThemeCubit()),
      BlocProvider(
          create: (context) =>
              LoginCubit(repository: context.read<AuthRepository>())),
      BlocProvider(
          create: (context) =>
              RegisterCubit(repository: context.read<AuthRepository>())),
    ];
  }

  /// 注册 Repository 依赖
  List<RepositoryProviderSingleChildWidget> get buildRepositoryProviders {
    return [
      RepositoryProvider(create: (context) => TodoRepository()),
      RepositoryProvider(create: (context) => AuthRepository()),
    ];
  }
}
