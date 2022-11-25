import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/router/app_router.dart';
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
          Cart(),
          Todos(),
          My(),
          Setting(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
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
