import 'package:demo/states/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnFlutterPage extends StatelessWidget {
  const LearnFlutterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder(
    //  bloc: context.read<MessageCubit>(),
    return BlocBuilder<MessageCubit, String?>(
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Learn Flutter'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    context.read<MessageCubit>().showMessage('Add pressed'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Image(image: AssetImage('images/logo.jpeg')),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  color: Colors.blueGrey,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Learn Flutter',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => debugPrint('ElevatedButton pressed'),
                  child: const Text('ElevatedButton'),
                ),
                OutlinedButton(
                  onPressed: () => debugPrint('OutlinedButton pressed'),
                  child: const Text('OutlinedButton'),
                ),
                TextButton(
                  onPressed: () => debugPrint('TextButton pressed'),
                  child: const Text('TextButton'),
                ),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => debugPrint('GestureDetector pressed'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        Text(
                            'Detect tapping (the row containing 2 children as a whole) with AbsorbPointer'),
                      ],
                    )
                    // child: AbsorbPointer(
                    //     // AbsorbPointer prevents the child from being pressed
                    //     child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: const [
                    //     Icon(Icons.add),
                    //     Text(
                    //         'Detect tapping (the row containing 2 children as a whole) with AbsorbPointer'),
                    //   ],
                    // )),
                    ),
                GestureDetector(
                  onTap: () => context.read<MessageCubit>().showMessage('blue'),
                  child: Container(
                    color: Colors.blue,
                    height: 100,
                    width: 400,
                    child: IgnorePointer(
                      ignoring: false,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 200,
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () =>
                                context.read<MessageCubit>().showMessage('red'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
