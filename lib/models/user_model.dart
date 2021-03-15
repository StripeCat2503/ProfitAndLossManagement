import 'package:pnL/models/store_model.dart';
import 'package:pnL/validations/login_validation.dart';
import 'dart:convert';

TokenLoginResponse tokenLoginResponseFromJson(String str) =>
    TokenLoginResponse.fromJson(json.decode(str));

String tokenLoginResponseToJson(TokenLoginResponse data) =>
    json.encode(data.toJson());

class TokenLoginResponse {
  TokenLoginResponse(
      {this.userId,
      this.username,
      this.accessToken,
      this.role,
      this.store,
      this.userValidation});

  String userId;
  String username;
  String accessToken;
  String role;
  Store store;
  List<UserValidation> userValidation;

  factory TokenLoginResponse.fromJson(Map<String, dynamic> json) =>
      TokenLoginResponse(
          userId: json["user-id"],
          username: json["username"],
          accessToken: json["access-token"],
          role: json["role"],
          store: Store.fromJson(json["store"]),
          userValidation: new List<UserValidation>());

  Map<String, dynamic> toJson() => {
        "user-id": userId,
        "username": username,
        "access-token": accessToken,
        "role": role,
        "store": store.toJson(),
      };
  fromJsonToValidation(Map<String, dynamic> json) {
    userValidation = new List<UserValidation>();
    var validation = new UserValidation();
    var data = json["data"];
    var message = json["message"];
    if (data.toLowerCase() == 'username') {
      validation.username = message;
    } else if (data.toLowerCase() == 'password') {
      validation.password = message;
    }
    userValidation.add(validation);
  }
}
