import 'package:flutter/cupertino.dart';



class LoginProvider extends ChangeNotifier {

  bool _hidePassword = true;



  get hidePassword => this._hidePassword;

  set hidePassword(value) {
    this._hidePassword = value;
    notifyListeners();
  }

  String? _email;
  String? password;

  get email => this._email;

  set email(value) {
    this._email = value;
    notifyListeners();
  }

  get getPassword => this.password;

  set setPassword(password) {
    this.password = password;
    notifyListeners();
  }
}
