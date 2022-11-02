import 'package:demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserFormBuilder(
      model: User('', '', ''),
      builder: (context, formModel, child) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
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
                  onPressed: form.form.valid
                      ? () {
                          debugPrint(form.model.username);
                          debugPrint(form.model.username);
                          debugPrint(form.model.password);
                        }
                      : null,
                  child: const Text('Submit'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
