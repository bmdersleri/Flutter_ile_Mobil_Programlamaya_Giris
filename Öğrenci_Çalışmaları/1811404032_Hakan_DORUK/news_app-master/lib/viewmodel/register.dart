import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier {
  bool _hidePassword = true;
  bool _hidePasswordAgain = true;

  get hidePassword => this._hidePassword;

  set hidePassword(value) {
    this._hidePassword = value;
    notifyListeners();
  }

  get hidePasswordAgain => this._hidePasswordAgain;

  set hidePasswordAgain(value) {
    this._hidePasswordAgain = value;
    notifyListeners();
  }

  String? email;
  String? passwordText;
  String? passwordAgainText;

  get getEmail => this.email;

  set setEmail(email) {
    this.email = email;
    notifyListeners();
  }

  get getPasswordText => this.passwordText;

  set setPasswordText(passwordText) {
    this.passwordText = passwordText;
    notifyListeners();
  }

  get getPasswordAgainText => this.passwordAgainText;

  set setPasswordAgainText(passwordAgainText) {
    this.passwordAgainText = passwordAgainText;
    notifyListeners();
  }
}
