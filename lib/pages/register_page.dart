import 'package:auto_route/auto_route.dart';
import 'package:demo/models/user.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/all.dart';
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
      model: User('', '', ''),
      builder: (context, formModel, child) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.read<LoadingProvider>().setLoad(false);
              context.router.navigate(const Home());
            } else if (state is RegisterError) {
              context.read<LoadingProvider>().setLoad(false);
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
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ReactiveTextField(
                  formControlName: 'username',
                  validationMessages: {
                    'required': (error) => 'Username is required',
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ReactiveTextField(
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
                ),
                const SizedBox(height: 16),
                ReactiveTextField(
                  formControlName: 'phone',
                  validationMessages: {
                    'required': (error) => 'Phone is required',
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ReactiveUserFormConsumer(builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (form.form.valid) {
                        context.read<RegisterCubit>().register(
                            form.user!.username,
                            form.user!.password,
                            form.user!.phone);
                      } else {
                        form.form.markAllAsTouched();
                      }
                    },
                    child: const Text('Register'),
                  );
                }),
                Center(
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        context.router.pop();
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is RegisterError) {
                        context.read<MessageCubit>().showMessage(state.message);
                        return Text(state.message);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
