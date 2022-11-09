import 'package:auto_route/auto_route.dart';
import 'package:demo/forms/login_form_widget.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/states/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget implements AutoRouteWrapper {
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

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(
        repository: context.read<AuthRepository>(),
        perfs: context.read<SharedPreferences>(),
      ),
      child: this,
    );
  }
}
