import 'package:demo/observers/nav_observer.dart';
import 'package:demo/pages/all.dart';
import 'package:demo/repositories/todo_repository.dart';
import 'package:demo/states/message_cubit.dart';
import 'package:demo/states/tab_cubit.dart';
import 'package:demo/states/theme_cubit.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leancloud_storage/leancloud.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeanCloud.initialize(
      'xvE7lpziyTMBjKCmfqbyjNKh-gzGzoHsz',
      '25wuss1uvHYt7dQbreGfojB2',
      queryCache: LCQueryCache(),
      server: 'https://feeds.twigcodes.com',
    );
    LCLogger.setLevel(LCLogger.DebugLevel);

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => TodoRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TabCubit()),
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => MessageCubit()),
            BlocProvider(
                create: (context) =>
                    TodoCubit(repository: context.read<TodoRepository>()))
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatelessWidget with WidgetsBindingObserver {
  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var brightness = WidgetsBinding.instance.window.platformBrightness;
    // context.read<ThemeCubit>().changeTheme(brightness);
    return themeAware();
  }

  BlocBuilder<ThemeCubit, ThemeData> themeAware() {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: router,
        );
      },
    );
  }

  final GoRouter router = GoRouter(
    observers: <NavigatorObserver>[NavObserver()],
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // LCUser currentUser = await LCUser.getCurrent();
          // if (currentUser != null) {
          //   // Redirect to the home page
          // } else {
          //   // Show the sign-up or log-in page
          // }
          return const RootPage();
        },
      ),
      GoRoute(
        name: 'learn',
        path: '/learn_flutter',
        builder: (BuildContext context, GoRouterState state) {
          return const LearnFlutterPage();
        },
      ),
      GoRoute(
        path: '/stream',
        builder: (BuildContext context, GoRouterState state) {
          return const CounterPage();
        },
      ),
      GoRoute(
        path: '/todo',
        builder: (BuildContext context, GoRouterState state) {
          return const TodoPage();
        },
      ),
    ],
  );
}
