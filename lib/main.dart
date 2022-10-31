import 'package:demo/pages/root_page.dart';
import 'package:demo/routes.dart';
import 'package:demo/states/tab_cubit.dart';
import 'package:demo/states/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(providers: [
      BlocProvider<TabCubit>(create: (context) => TabCubit()),
      BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget with WidgetsBindingObserver {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var brightness = WidgetsBinding.instance.window.platformBrightness;
    // context.read<ThemeCubit>().changeTheme(brightness);
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routes: routes,
          home: const RootPage(),
        );
      },
    );
  }
}
