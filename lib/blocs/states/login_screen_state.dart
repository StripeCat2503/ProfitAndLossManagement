import 'package:pnL/models/enum_field_error.dart';

class LoginScreenState {
  final bool isBusy;
  final FieldError emailError;
  final FieldError usernameError;
  final FieldError passwordError;
  final bool isValidation;
  final bool isLogin;
  LoginScreenState(
      {this.isBusy: false,
      this.emailError,
      this.usernameError,
      this.passwordError,
      this.isValidation,
      this.isLogin = false});
}
