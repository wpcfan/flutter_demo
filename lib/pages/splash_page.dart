import 'package:auto_route/auto_route.dart';
import 'package:demo/config.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state == const SplashComplete()) {
            context.router.replace(const RootRoute());
          }
        },
        child: SizedBox.expand(
            child: GestureDetector(
          onTap: () {
            context.read<SplashBloc>().add(const SplashStop());
          },
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  alignment: FractionalOffset.center,
                  child: Image.network('$placeholderUri/150'),
                ),
                Container(
                  alignment: FractionalOffset.topRight,
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                    return Container(
                      color: Colors.grey,
                      width: 60,
                      height: 20,
                      alignment: Alignment.center,
                      child: Text(
                        '${state.count}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
