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
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: BlocListener<SplashBloc, int>(
        listener: (context, state) {
          if (state == 0) {
            context.router.replace(const RootRoute());
          }
        },
        child: SizedBox.expand(
          child: BlocBuilder<SplashBloc, int>(builder: (context, state) {
            context.read<SplashBloc>().add(const SplashCountdown());
            return GestureDetector(
              onTap: () {
                context.read<SplashBloc>().add(const SplashComplete());
              },
              child: Stack(
                children: [
                  Container(
                    alignment: FractionalOffset.center,
                    width: 150,
                    height: 150,
                    child: Image.network('$placeholderUri/150'),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 60,
                    height: 20,
                    alignment: FractionalOffset.topRight,
                    child: Text(
                      '$state',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
