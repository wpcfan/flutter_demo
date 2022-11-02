import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/message_cubit.dart';
import 'package:demo/states/theme_cubit.dart';
import 'package:demo/widgets/tabbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, String?>(
      listener: ((context, state) => showSnackMsg(state, context)),
      child: AutoTabsRouter(
        routes: const [
          Home(),
          Counter(),
          Todo(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Demo Home Page'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              child: const Icon(Icons.toggle_on),
            ),
            body: FadeTransition(
              opacity: animation,
              // the passed child is techinaclly our animated selected-tab page
              child: child,
            ),
            bottomNavigationBar: TabbarWidget(tabsRouter: tabsRouter),
          );
        },
      ),
    );
  }

  void showSnackMsg(String? state, BuildContext context) {
    if (state != null) {
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state),
      ));
    }
  }
}
