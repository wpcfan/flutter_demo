import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget implements AutoRouteWrapper {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: ((context, state) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                BlocBuilder<CounterCubit, int>(
                  builder: (context, state) => Text(
                    '$state',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => context.read<CounterCubit>().increment(),
                    child: const Text('Increment')),
                ElevatedButton(
                    onPressed: () => context.read<CounterCubit>().decrement(),
                    child: const Text('Decrement')),
              ],
            ),
          )),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: this,
    );
  }
}
