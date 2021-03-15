import 'package:pnL/resources/constain_login_request.dart';

class UserLogin {
  String username;
  String password;
  String firebaseToken;
  String requestType;
  UserLogin({this.requestType = LoginRequestType.LOCAL_USER});
  UserLogin.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        firebaseToken = json["firebase-token"];
  Map<String, dynamic> filterToJson() => {
        'username': username.toString(),
        'password': password.toString(),
        'firebase-token': firebaseToken.toString()
      };
}
