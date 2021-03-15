import 'dart:async';
import 'dart:convert' as json;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pnL/blocs/events/form_screen_event.dart';
import 'package:pnL/blocs/states/login_screen_state.dart';
import 'package:pnL/mixins/validation_mixins.dart';
import 'package:pnL/models/api_result_model.dart';
import 'package:pnL/models/enum_field_error.dart';
import 'package:pnL/models/login_request.dart';
import 'package:pnL/models/user_model.dart';
import 'package:pnL/repositories/receipt_new_repository.dart';
import 'package:pnL/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pnL/resources/constain_login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<LoginScreenEvent, LoginScreenState>
    with ValidationMixin {
  final _controller =
      StreamController<TokenLoginResponse>(); // Khai báo Stream // quan ly
  final UserRepository _provider = UserRepository();
  Stream<TokenLoginResponse> get stream =>
      _controller.stream; //get steam đưa dữ liệu
  UserLogin _userLogin = new UserLogin();
  TokenLoginResponse _userModel = new TokenLoginResponse();
  UserLogin get getUserLogin => _userLogin;
  TokenLoginResponse get getUserToken => _userModel;
  bool loginSuccess = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<AuthResult> _handleSignIn(username, pass) async {
    try {
      // GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      // GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthResult user = await _auth.signInWithEmailAndPassword(
          email: username, password: pass);
      return user;
    } catch (e) {}
    return null;
  }

  Future<bool> login(Map<String, dynamic> data) async {
    _userModel = await _provider.login(data); // goi api lay du lieu
    if (_userModel.userValidation.length == 0) {
      // Create storage
      final storage = new FlutterSecureStorage();
      // Write value
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('user', json.jsonEncode(_userModel));
      });
      loginSuccess = true;
      return true;
    }
    _controller.sink.add(_userModel);
    return false;
  }

  @override
  LoginScreenState get initialState => LoginScreenState();
  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is LoginScreenEventSubmit) {
      bool isValid = true;
      yield LoginScreenState(isBusy: true);
      var usernameError;
      var passwordError;
      if (event.isUsingEmail) {
        if (this.isFieldEmpty(event.username)) {
          usernameError = FieldError.Empty;
          isValid = false;
        }
      } else {
        if (this.isFieldEmpty(event.username)) {
          usernameError = FieldError.Empty;
          isValid = false;
        }
        if (this.isFieldEmpty(event.password)) {
          passwordError = FieldError.Empty;
          isValid = false;
        }
      }

      // check login done
      if (isValid) {
        _userLogin.username = event.username;
        _userLogin.password = event.password;
        if (event.isUsingEmail) {
          var user = await _handleSignIn(event.username, event.password);
          if (user != null) {
            final user = await FirebaseAuth.instance.currentUser();
            final idToken = await user.getIdToken();
            final token = idToken.token;
            _userLogin.firebaseToken = token;
            _userLogin.requestType = LoginRequestType.FIREBASE_USER;
          }
        }
        if (!(_userLogin.username?.isEmpty ?? true)) {
          try {
            bool isLogin = await login(_userLogin.filterToJson());
            if (isLogin) {
              yield LoginScreenState(isLogin: true);
            } else {
              yield LoginScreenState(
                  usernameError: FieldError.Invalid,
                  isValidation: isValid,
                  isLogin: false);
            }
          } catch (e) {
            yield LoginScreenState(
                usernameError: FieldError.Invalid,
                isValidation: isValid,
                isLogin: false);
          }
        }
      } else {
        yield LoginScreenState(
            usernameError: usernameError,
            passwordError: passwordError,
            isValidation: isValid,
            isLogin: false);
      }
      // yield LoginScreenState(isValidation: isValid);
    }
  }

  void dispose() {
    // TODO: implement dispose
    _controller.close();
  }
}
