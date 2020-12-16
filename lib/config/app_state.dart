import 'package:flutter/cupertino.dart';

class AppState with ChangeNotifier {
  bool gray;

  AppState({bool gray = false}) {
    this.gray = gray;
  }

  get getGray => gray;

  switchGray() {
    this.gray = !this.gray;
    notifyListeners();
  }
}
