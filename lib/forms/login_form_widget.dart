import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/states/login_cubit.dart';
import 'package:demo/widgets/loading_overlay/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = false;
  bool _usernameHasError = false;
  bool _passwordHasError = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: reducer,
      child: form(context),
    );
  }

  void reducer(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      context.read<LoadingProvider>().setLoad(false);
      context.router.navigate(const RootRoute());
    } else if (state is LoginError) {
      context.read<LoadingProvider>().setLoad(false);
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    } else if (state is LoginLoading) {
      context.read<LoadingProvider>().setLoad(true);
    } else {
      context.read<LoadingProvider>().setLoad(false);
    }
  }

  /// 用户名输入框
  Widget usernameFormField() {
    return FormBuilderTextField(
      name: 'username',
      decoration: InputDecoration(
        labelText: 'Username',
        prefix: _usernameHasError
            ? const Icon(Icons.error, color: Colors.red)
            : const Icon(Icons.check, color: Colors.green),
      ),
      onChanged: (val) => setState(() => _usernameHasError =
          !(_formKey.currentState?.fields['username']?.validate() ?? false)),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
      ]),
    );
  }

  /// 密码输入框
  Widget passwordFormField() {
    return FormBuilderTextField(
      name: 'password',
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        prefix: _passwordHasError
            ? const Icon(Icons.error, color: Colors.red)
            : const Icon(Icons.check, color: Colors.green),
        suffix: IconButton(
          icon: _passwordVisible
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.remove_red_eye_outlined),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
      ),
      onChanged: (val) => setState(() => _passwordHasError =
          !(_formKey.currentState?.fields['password']?.validate() ?? false)),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
      ]),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          context.read<LoginCubit>().login(
                _formKey.currentState?.fields['username']?.value,
                _formKey.currentState?.fields['password']?.value,
              );
        } else {
          debugPrint(_formKey.currentState?.value.toString());
          debugPrint('validation failed');
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget resetButton() {
    return OutlinedButton(
      onPressed: () {
        _formKey.currentState?.reset();
      },
      // color: Theme.of(context).colorScheme.secondary,
      child: Text(
        'Reset',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  Widget navRegisterButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.router.pushNamed('/register-page');
      },
      child: const Text('Register'),
    );
  }

  /// 构建登录表单
  Widget form(BuildContext context) {
    return Center(
        child: Column(
      children: [
        FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
            debugPrint(_formKey.currentState!.value.toString());
          },
          autovalidateMode: AutovalidateMode.disabled,
          initialValue: const {
            'username': '',
            'password': '',
          },
          skipDisabled: true,
          child: Column(
            children: [
              usernameFormField(),
              passwordFormField(),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: submitButton(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: resetButton(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: navRegisterButton(context),
            ),
          ],
        ),
      ],
    ));
  }
}
