import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: BlocBuilder<PageBlockBloc, PageBlockState>(
          builder: (_, state) {
            if (state.status == PageBlockStatus.initial) {
              return const CircularProgressIndicator();
            }
            if (state.status == PageBlockStatus.failure) {
              return Text(state.error ?? 'Something went wrong');
            }
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Home'),
                  floating: true,
                  snap: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final pageBlock = state.pageBlocks[index];
                      switch (pageBlock.type) {
                        case PageBlockType.slider:
                          final sliderPageBlock = pageBlock as SliderPageBlock;
                          return ImageSlider(children: [
                            for (final image in sliderPageBlock.data)
                              Image.network(image.image)
                          ]);
                      }
                    },
                    childCount: state.pageBlocks.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PageBlockBloc(repository: context.read<PageBlockRepository>())
            ..add(PageBlockFetched()),
      child: this,
    );
  }
}
