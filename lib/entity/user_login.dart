import 'dart:core';

import 'package:flutter/cupertino.dart';

class UserLogin {
  String username;
  String password;

  UserLogin({
    @required this.username,
    @required this.password,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
