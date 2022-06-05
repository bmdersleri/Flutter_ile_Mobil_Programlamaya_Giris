import 'package:flutter/material.dart';
import 'package:vs_code_gelirgider_takip/login_page.dart';
import 'package:vs_code_gelirgider_takip/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignUp:toggle)
      :Register(onClickedSignIn:toggle);
  void toggle() => setState(()=>isLogin = !isLogin);

}
