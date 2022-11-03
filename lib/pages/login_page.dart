import 'package:demo/forms/login_form_widget.dart';
import 'package:demo/states/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const LoginFormWidget(),
      );
    });
  }
}
