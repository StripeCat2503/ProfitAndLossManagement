abstract class LoginScreenEvent {}

class LoginScreenEventSubmit extends LoginScreenEvent {
  final String email;
  final String username;
  final String password;
  final bool isLogin;
  bool isUsingEmail;
  LoginScreenEventSubmit(
      {this.email,
      this.username,
      this.password,
      this.isLogin = false,
      this.isUsingEmail = false});
}
