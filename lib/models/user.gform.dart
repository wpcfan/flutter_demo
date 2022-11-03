// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file:

part of 'user.dart';

// **************************************************************************
// ReactiveFormsGenerator
// **************************************************************************

class ReactiveUserFormConsumer extends StatelessWidget {
  const ReactiveUserFormConsumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget? child;

  final Widget Function(BuildContext context, UserForm formModel, Widget? child)
      builder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveUserForm.of(context);

    if (formModel is! UserForm) {
      throw FormControlParentNotFoundException(this);
    }
    return builder(context, formModel, child);
  }
}

class UserFormInheritedStreamer extends InheritedStreamer<dynamic> {
  const UserFormInheritedStreamer({
    Key? key,
    required this.form,
    required Stream<dynamic> stream,
    required Widget child,
  }) : super(
          stream,
          child,
          key: key,
        );

  final UserForm form;
}

class ReactiveUserForm extends StatelessWidget {
  const ReactiveUserForm({
    Key? key,
    required this.form,
    required this.child,
    this.onWillPop,
  }) : super(key: key);

  final Widget child;

  final UserForm form;

  final WillPopCallback? onWillPop;

  static UserForm? of(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<UserFormInheritedStreamer>()
          ?.form;
    }

    final element = context
        .getElementForInheritedWidgetOfExactType<UserFormInheritedStreamer>();
    return element == null
        ? null
        : (element.widget as UserFormInheritedStreamer).form;
  }

  @override
  Widget build(BuildContext context) {
    return UserFormInheritedStreamer(
      form: form,
      stream: form.form.statusChanged,
      child: WillPopScope(
        onWillPop: onWillPop,
        child: child,
      ),
    );
  }
}

class UserFormBuilder extends StatefulWidget {
  const UserFormBuilder({
    Key? key,
    this.model,
    this.child,
    this.onWillPop,
    required this.builder,
    this.initState,
  }) : super(key: key);

  final User? model;

  final Widget? child;

  final WillPopCallback? onWillPop;

  final Widget Function(BuildContext context, UserForm formModel, Widget? child)
      builder;

  final void Function(BuildContext context, UserForm formModel)? initState;

  @override
  _UserFormBuilderState createState() => _UserFormBuilderState();
}

class _UserFormBuilderState extends State<UserFormBuilder> {
  late FormGroup _form;

  late UserForm _formModel;

  @override
  void initState() {
    _form = FormGroup({});
    _formModel = UserForm(widget.model, _form, null);

    final elements = _formModel.formElements();
    _form.setValidators(elements.validators);
    _form.setAsyncValidators(elements.asyncValidators);

    if (elements.disabled) {
      _form.markAsDisabled();
    }

    _form.addAll(elements.controls);

    widget.initState?.call(context, _formModel);

    super.initState();
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveUserForm(
      form: _formModel,
      onWillPop: widget.onWillPop,
      child: ReactiveFormBuilder(
        form: () => _form,
        onWillPop: widget.onWillPop,
        builder: (BuildContext context, FormGroup formGroup, Widget? child) =>
            widget.builder(context, _formModel, widget.child),
        child: widget.child,
      ),
    );
  }
}

class UserForm implements FormModel<User> {
  UserForm(
    this.user,
    this.form,
    this.path,
  ) {}

  static String usernameControlName = "username";

  static String passwordControlName = "password";

  static String phoneControlName = "phone";

  final User? user;

  final FormGroup form;

  final String? path;

  String usernameControlPath() => pathBuilder(usernameControlName);
  String passwordControlPath() => pathBuilder(passwordControlName);
  String phoneControlPath() => pathBuilder(phoneControlName);
  String? get _usernameValue => usernameControl?.value;
  String? get _passwordValue => passwordControl?.value;
  String? get _phoneValue => phoneControl?.value;
  bool get containsUsername {
    try {
      form.control(usernameControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get containsPassword {
    try {
      form.control(passwordControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get containsPhone {
    try {
      form.control(phoneControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  Object? get usernameErrors => usernameControl?.errors;
  Object? get passwordErrors => passwordControl?.errors;
  Object? get phoneErrors => phoneControl?.errors;
  void get usernameFocus => form.focus(usernameControlPath());
  void get passwordFocus => form.focus(passwordControlPath());
  void get phoneFocus => form.focus(phoneControlPath());
  void usernameRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsUsername) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          usernameControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            usernameControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  void passwordRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsPassword) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          passwordControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            passwordControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  void phoneRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsPhone) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          phoneControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            phoneControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  void usernameValueUpdate(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl?.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void passwordValueUpdate(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl?.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void phoneValueUpdate(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    phoneControl?.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void usernameValuePatch(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    usernameControl?.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void passwordValuePatch(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    passwordControl?.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void phoneValuePatch(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    phoneControl?.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void usernameValueReset(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      usernameControl?.reset(
          value: value, updateParent: updateParent, emitEvent: emitEvent);
  void passwordValueReset(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      passwordControl?.reset(
          value: value, updateParent: updateParent, emitEvent: emitEvent);
  void phoneValueReset(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      phoneControl?.reset(
          value: value, updateParent: updateParent, emitEvent: emitEvent);
  FormControl<String>? get usernameControl => containsUsername
      ? form.control(usernameControlPath()) as FormControl<String>?
      : null;
  FormControl<String>? get passwordControl => containsPassword
      ? form.control(passwordControlPath()) as FormControl<String>?
      : null;
  FormControl<String>? get phoneControl => containsPhone
      ? form.control(phoneControlPath()) as FormControl<String>?
      : null;
  void usernameSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      usernameControl?.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      usernameControl?.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void passwordSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      passwordControl?.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      passwordControl?.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void phoneSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      phoneControl?.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      phoneControl?.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  User get model {
    if (!form.valid) {
      debugPrint(
        'Prefer not to call `model` on non-valid form it could cause unexpected exceptions in case you created a non-nullable field in model and expect it to be guarded by some kind of `required` validator.',
      );
    }
    return User(
        username: _usernameValue,
        password: _passwordValue,
        phone: _phoneValue,
        objectId: user?.objectId,
        sessionToken: user?.sessionToken,
        updatedAt: user?.updatedAt,
        createdAt: user?.createdAt,
        emailVerified: user?.emailVerified,
        mobilePhoneVerified: user?.mobilePhoneVerified);
  }

  UserForm copyWithPath(String? path) {
    return UserForm(user, form, path);
  }

  void updateValue(
    User value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.updateValue(
          UserForm(value, FormGroup({}), null).formElements().rawValue,
          updateParent: updateParent,
          emitEvent: emitEvent);
  void resetValue(
    User value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.reset(
          value: UserForm(value, FormGroup({}), null).formElements().rawValue,
          updateParent: updateParent,
          emitEvent: emitEvent);
  void reset({
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.reset(
          value: formElements().rawValue,
          updateParent: updateParent,
          emitEvent: emitEvent);
  String pathBuilder(String? pathItem) =>
      [path, pathItem].whereType<String>().join(".");
  FormGroup formElements() => FormGroup({
        usernameControlName: FormControl<String>(
            value: user?.username,
            validators: [requiredValidator, minLengthValidator],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        passwordControlName: FormControl<String>(
            value: user?.password,
            validators: [requiredValidator],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        phoneControlName: FormControl<String>(
            value: user?.phone,
            validators: [requiredValidator],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false)
      },
          validators: [],
          asyncValidators: [],
          asyncValidatorsDebounceTime: 250,
          disabled: false);
}

class ReactiveUserFormArrayBuilder<T> extends StatelessWidget {
  const ReactiveUserFormArrayBuilder({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
  })  : assert(control != null || formControl != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final FormArray<T>? formControl;

  final FormArray<T>? Function(UserForm formModel)? control;

  final Widget Function(
      BuildContext context, List<Widget> itemList, UserForm formModel)? builder;

  final Widget Function(
      BuildContext context, int i, T? item, UserForm formModel) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveUserForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    return ReactiveFormArray<T>(
      formArray: formControl ?? control?.call(formModel),
      builder: (context, formArray, child) {
        final itemList = (formArray.value ?? [])
            .asMap()
            .map((i, item) {
              return MapEntry(
                i,
                itemBuilder(
                  context,
                  i,
                  item,
                  formModel,
                ),
              );
            })
            .values
            .toList();

        return builder?.call(
              context,
              itemList,
              formModel,
            ) ??
            Column(children: itemList);
      },
    );
  }
}

class ReactiveUserFormFormGroupArrayBuilder<V> extends StatelessWidget {
  const ReactiveUserFormFormGroupArrayBuilder({
    Key? key,
    this.extended,
    this.getExtended,
    this.builder,
    required this.itemBuilder,
  })  : assert(extended != null || getExtended != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final ExtendedControl<List<Map<String, Object?>?>, List<V>>? extended;

  final ExtendedControl<List<Map<String, Object?>?>, List<V>> Function(
      UserForm formModel)? getExtended;

  final Widget Function(
      BuildContext context, List<Widget> itemList, UserForm formModel)? builder;

  final Widget Function(
      BuildContext context, int i, V? item, UserForm formModel) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveUserForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final value = (extended ?? getExtended?.call(formModel))!;

    return StreamBuilder<List<Map<String, Object?>?>?>(
      stream: value.control.valueChanges,
      builder: (context, snapshot) {
        final itemList = (value.value() ?? <V>[])
            .asMap()
            .map((i, item) => MapEntry(
                  i,
                  itemBuilder(
                    context,
                    i,
                    item,
                    formModel,
                  ),
                ))
            .values
            .toList();

        return builder?.call(
              context,
              itemList,
              formModel,
            ) ??
            Column(children: itemList);
      },
    );
  }
}
