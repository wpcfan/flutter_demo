import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/config.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/widgets/page_blocks/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

part './home_page_desktop.dart';
part './home_page_header_delegate.dart';
part './home_page_mobile.dart';
part './home_page_waterfall.dart';
part './home_page_waterfall_tabbar.dart';

class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bloc = context.read<PageBlockBloc>();
      if (constraints.maxWidth < 600) {
        bloc.add(const PageBlockFetched('mobile'));
        return const MobileHomePage();
      } else {
        bloc.add(const PageBlockFetched('desktop'));
        return const DesktopHomePage();
      }
    });
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<PageBlockBloc>(
      create: (context) =>
          PageBlockBloc(repository: context.read<PageBlockRepository>()),
      child: this,
    );
  }
}
