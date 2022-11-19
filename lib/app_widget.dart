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
      providers: [
        RepositoryProvider<SharedPreferences>(
          create: (context) => sharedPreferences,
        ),
        RepositoryProvider<Dio>(
          create: (context) => Dio()
            ..interceptors.add(
              LogInterceptor(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                responseHeader: true,
              ),
            )
            ..interceptors.add(
              LeanCloudInterceptor(
                sharedPreferences.getString('sessionToken'),
                appId: lcAppId,
                appKey: lcAppKey,
              ),
            )
            ..interceptors.add(
              ContentTypeInterceptor(),
            ),
        ),
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(context.read<Dio>())),
        RepositoryProvider<PageBlockRepository>(
            create: (context) => PageBlockRepository(context.read<Dio>())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => MessageCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(
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
    );
  }
}
