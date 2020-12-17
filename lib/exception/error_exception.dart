import 'package:flutter/material.dart';

class ErrorException implements Exception {

  int code;
  String message;

  ErrorException({@required this.code, @required this.message});

  String toString() {
    return "Exception:code:[$code], message:[$message]";
  }
}
