import 'package:auto_route/auto_route.dart';
import 'package:demo/models/user.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/register_cubit.dart';
import 'package:demo/widgets/loading_overlay/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserFormBuilder(
      model: User(),
      builder: (context, formModel, child) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: reducer,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                usernameField(),
                const SizedBox(height: 16),
                passwordField(),
                const SizedBox(height: 16),
                phoneField(),
                const SizedBox(height: 16),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reducer(BuildContext context, RegisterState state) {
    if (state is RegisterSuccess) {
      context.read<LoadingProvider>().setLoad(false);
      context.router.navigate(const RootRoute());
    } else if (state is RegisterError) {
      context.read<LoadingProvider>().setLoad(false);
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    } else if (state is RegisterLoading) {
      context.read<LoadingProvider>().setLoad(true);
    } else {
      context.read<LoadingProvider>().setLoad(false);
    }
  }

  ReactiveTextField<dynamic> usernameField() {
    return ReactiveTextField(
      formControlName: 'username',
      validationMessages: {
        'required': (error) => 'Username is required',
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
  }

  ReactiveTextField<dynamic> passwordField() {
    return ReactiveTextField(
      formControlName: 'password',
      validationMessages: {
        'required': (error) => 'Password is required',
      },
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  ReactiveTextField<dynamic> phoneField() {
    return ReactiveTextField(
      formControlName: 'phone',
      validationMessages: {
        'required': (error) => 'Phone is required',
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Phone',
        border: OutlineInputBorder(),
      ),
    );
  }

  ReactiveUserFormConsumer submitButton() {
    return ReactiveUserFormConsumer(builder: (context, form, child) {
      return BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (form.form.valid && state is! RegisterLoading) {
              context.read<RegisterCubit>().register(form.model.username!,
                  form.model.password!, form.model.phone!);
            } else {
              form.form.markAllAsTouched();
            }
          },
          child: const Text('Register'),
        );
      });
    });
  }
}
