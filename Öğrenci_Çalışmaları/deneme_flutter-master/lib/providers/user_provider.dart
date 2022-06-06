import 'package:deneme_flutter/models/user.dart';
import 'package:deneme_flutter/resources/auth_method.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetatils();
    _user = user;
    notifyListeners();
  }
}
