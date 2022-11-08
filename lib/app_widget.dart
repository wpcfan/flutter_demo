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
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => PageBlockRepository()),
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
