import 'package:demo/states/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
