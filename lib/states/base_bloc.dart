import 'package:flutter/material.dart';

abstract class BaseBloc {
  void dispose();
}

class RxBlocProvider<T extends BaseBloc> extends StatefulWidget {
  const RxBlocProvider(
      {super.key, required this.blocSupplier, required this.child});
  final T Function() blocSupplier;
  final Widget child;

  @override
  State<RxBlocProvider> createState() => _RxBlocProviderState();

  static T of<T extends BaseBloc>(BuildContext context) {
    _BlocProviderInheritedWidget<T>? provider = context
        .dependOnInheritedWidgetOfExactType<_BlocProviderInheritedWidget<T>>();
    if (provider == null) {
      throw StateError(
          'Cannot get provider with type ${_typeOf<_BlocProviderInheritedWidget<T>>()}');
    }
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _RxBlocProviderState<T extends BaseBloc>
    extends State<RxBlocProvider<T>> {
  late T _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.blocSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInheritedWidget<T>(
      _bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    debugPrint('[DEBUG] Bloc disposed');
    super.dispose();
  }
}

class _BlocProviderInheritedWidget<T extends BaseBloc> extends InheritedWidget {
  final T bloc;

  const _BlocProviderInheritedWidget(this.bloc, {required super.child});

  @override
  bool updateShouldNotify(_BlocProviderInheritedWidget old) => bloc != old.bloc;
}
