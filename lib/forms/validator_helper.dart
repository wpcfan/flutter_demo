import 'package:reactive_forms/reactive_forms.dart';

Map<String, dynamic>? requiredValidator(AbstractControl<dynamic> control) {
  return Validators.required(control);
}

Map<String, dynamic>? minLengthValidator(AbstractControl<dynamic> control) {
  return Validators.minLength(3)(control);
}
