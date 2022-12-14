import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget implements AutoRouteWrapper {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state == const SplashComplete()) {
          context.router.popUntilRoot();
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
                child: Image.network(
                  '$placeholderUri/150',
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('error: $error');
                    return Image.asset('images/100x100.png');
                  },
                ),
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
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: this,
    );
  }
}
