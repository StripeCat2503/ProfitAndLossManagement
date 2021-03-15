import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnL/blocs/events/form_screen_event.dart';
import 'package:pnL/blocs/states/login_screen_state.dart';
import 'package:pnL/blocs/user_bloc.dart';
import 'package:pnL/main.dart';
import 'package:pnL/models/enum_field_error.dart';
import 'package:pnL/models/login_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pnL/themes/custom_control.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorTheme;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserLogin _userLogin;
  UserBloc _bloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  int _pageState = 0;
  final _formKeyDefault = GlobalKey<FormState>();
  final _formKeyFirebase = GlobalKey<FormState>();
  var _backgroundColor = Colors.white;
  var _headingColor = ColorTheme.themeColorScheme.primaryVariant;

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _bloc = new UserBloc();
    _userLogin = new UserLogin();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        });
      },
    );
  }

  UnderlineInputBorder _renderBorder(LoginScreenState state) =>
      UnderlineInputBorder(
        borderSide: BorderSide(
            color: this._hasEmailError(state) ? Colors.red : Colors.black,
            width: 1),
      );

  bool _hasEmailError(LoginScreenState state) => state.emailError != null;
  bool _hasPasswordError(LoginScreenState state) => state.passwordError != null;
  bool _hasUsernameError(LoginScreenState state) => state.usernameError != null;

  String _emailErrorText(FieldError error) {
    switch (error) {
      case FieldError.Empty:
        return 'You need to enter an email address';
      case FieldError.Invalid:
        return 'Email address invalid';
      default:
        return '';
    }
  }

  String usernameValidator(String username) {
    if (username?.isEmpty ?? true) {
      return "Username empty";
    }
    return '';
  }

  String passwordValidator(String password) {
    if (password?.isEmpty ?? true) {
      return 'Password empty';
    } else if (password.length < 6) {
      return 'Password too short';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = ColorTheme.themeColorScheme.onSurface;

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = ColorTheme.themeColorScheme.primary;
        _headingColor = ColorTheme.themeColorScheme.primaryVariant;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = ColorTheme.themeColorScheme.primary;
        _headingColor = ColorTheme.themeColorScheme.primaryVariant;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        break;
    }

    return BlocListener<UserBloc, LoginScreenState>(
      bloc: this._bloc,
      listener: (context, state) {
        if (state.isLogin) {
          setState(() {
            _pageState = 0;
          });
          var userLogin = this._bloc.getUserToken;
          showDialog(
            context: context,
            child: AlertDialog(
                title: Text('Login!'),
                content: Text("Login successfully"),
                actions: [
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => {
                      Navigator.of(context, rootNavigator: true).pop(),
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyHomePage(userlogin: userLogin);
                      }))
                    },
                  ),
                ]),
          );
        } else if (!state.isBusy) {
          showDialog(
            context: context,
            child: AlertDialog(
                title: Text('Login!'),
                content: Text("Login failed"),
                actions: [
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => {
                      Navigator.of(context, rootNavigator: true).pop(),
                    },
                  ),
                ]),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                color: _backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            AnimatedContainer(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(milliseconds: 1000),
                              margin: EdgeInsets.only(
                                top: _headingTop,
                              ),
                              child: Text(
                                "PnL Project",
                                style: TextStyle(
                                    color: ColorTheme.primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: Image.asset("assets/images/splash_bg.png"),
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_pageState != 0) {
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorTheme.primaryColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            AnimatedContainer(
              padding: EdgeInsets.all(32),
              width: _loginWidth,
              height: _loginHeight,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform:
                  Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_loginOpacity),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Form(
                key: _formKeyDefault,
                child: BlocBuilder<UserBloc, LoginScreenState>(
                    bloc: this._bloc,
                    builder: (context, state) {
                      if (state.isBusy) {
                        return CircularProgressIndicator();
                      }

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Login To Continue",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: ColorTheme.primaryColor),
                                  ),
                                ),
                                InputWithIcon(
                                  icon: Icons.person,
                                  hint: "Username...",
                                  isPassword: false,
                                  onChange: (value) => setState(() {
                                    _userLogin.username = value.trim();
                                  }),
                                  controller: this._usernameController,
                                  style: TextStyle(
                                    color: this._hasEmailError(state)
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                if (this._hasUsernameError(state)) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    this.usernameValidator(_userLogin.username),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                                SizedBox(
                                  height: 10,
                                ),
                                InputWithIcon(
                                  icon: Icons.vpn_key,
                                  hint: "Password...",
                                  isPassword: true,
                                  onChange: (value) => setState(() {
                                    _userLogin.password = value.trim();
                                  }),
                                  controller: this._passwordController,
                                  style: TextStyle(
                                    color: this._hasPasswordError(state)
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                if (this._hasPasswordError(state)) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    this.passwordValidator(_userLogin.password),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    this._bloc.add(LoginScreenEventSubmit(
                                        username: this._usernameController.text,
                                        password:
                                            this._passwordController.text));
                                  },
                                  child: PrimaryButton(
                                    btnText: "Login",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _pageState = 2;
                                      _usernameController.text = '';
                                      _passwordController.text = '';
                                    });
                                  },
                                  child: OutlineBtn(
                                    btnText: "Login with firebase",
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            AnimatedContainer(
              height: _registerHeight,
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _registerYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Form(
                key: _formKeyFirebase,
                child: BlocBuilder<UserBloc, LoginScreenState>(
                    bloc: this._bloc,
                    builder: (context, state) {
                      if (state.isBusy) {
                        return CircularProgressIndicator();
                      }

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Firebase login",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                InputWithIcon(
                                  icon: Icons.person,
                                  hint: "Enter email...",
                                  isPassword: false,
                                  onChange: (value) => setState(() {
                                    _userLogin.username = value.trim();
                                  }),
                                  controller: this._usernameController,
                                  style: TextStyle(
                                    color: this._hasUsernameError(state)
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                if (this._hasUsernameError(state)) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    this.usernameValidator(_userLogin.username),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                                SizedBox(
                                  height: 20,
                                ),
                                InputWithIcon(
                                  icon: Icons.vpn_key,
                                  hint: "Enter Password...",
                                  isPassword: true,
                                  onChange: (value) => setState(() {
                                    _userLogin.password = value.trim();
                                  }),
                                  controller: this._passwordController,
                                  style: TextStyle(
                                    color: this._hasPasswordError(state)
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                                if (this._hasPasswordError(state)) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    this.passwordValidator(_userLogin.password),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    this._bloc.add(LoginScreenEventSubmit(
                                        username: this._usernameController.text,
                                        password: this._passwordController.text,
                                        isUsingEmail: true));
                                  },
                                  child: PrimaryButton(
                                    btnText: "Login",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _pageState = 1;
                                      _usernameController.text = '';
                                      _passwordController.text = '';
                                    });
                                  },
                                  child: OutlineBtn(
                                    btnText: "Back To Login",
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
