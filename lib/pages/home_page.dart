import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

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
                          return buildSlider(pageBlock, context);
                        case PageBlockType.imageList:
                          return buildImageList(pageBlock, context);
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

  Widget buildImageList(PageBlock pageBlock, BuildContext context) {
    final imageListPageBlock = pageBlock as ImageListPageBlock;
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pageBlock.data.length,
        itemBuilder: (_, index) {
          final item = imageListPageBlock.data[index];
          return GestureDetector(
            onTap: () {
              switch (item.link.type) {
                case LinkType.url:
                case LinkType.deepLink:
                  context.router.pushNamed(item.link.value);
                  break;
              }
            },
            child: SizedBox(
              width: 200,
              child: Image.network(item.image),
            ),
          );
        },
      ),
    );
  }

  CarouselSlider buildSlider(PageBlock pageBlock, BuildContext context) {
    final sliderPageBlock = pageBlock as SliderPageBlock;
    final aspectRatio =
        (sliderPageBlock.width ?? 400) / (sliderPageBlock.height ?? 150);
    final height = MediaQuery.of(context).size.height * 0.2;
    final width = height * aspectRatio;
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: sliderPageBlock.data.map((el) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                debugPrint('link: ${el.link}');
              },
              child: Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Image.network(
                  el.image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
