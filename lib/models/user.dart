import 'package:demo/forms/validator_helper.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'user.gform.dart';

@ReactiveFormAnnotation()
class User {
  final String username;
  final String password;
  final String phone;

  User(
      @FormControlAnnotation(validators: [requiredValidator]) this.username,
      @FormControlAnnotation(validators: [requiredValidator]) this.password,
      @FormControlAnnotation(validators: [requiredValidator]) this.phone);
}
