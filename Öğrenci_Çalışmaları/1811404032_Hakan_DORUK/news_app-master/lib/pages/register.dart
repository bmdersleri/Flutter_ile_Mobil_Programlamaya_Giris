import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constance/colors.dart';
import 'package:news_app/constance/icons.dart';
import 'package:news_app/constance/padding.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/viewmodel/register.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final String _registerText = "Kayıt Ol";
  final _emailHintText = "Email Giriniz";
  final _passwordHintText = "Şifrenizi Giriniz";
  final _passwordAgainText = "Şifreyi Tekrar Giriniz";
  final _formState = GlobalKey<FormState>();

  late RegisterProvider _registerProvider;

  @override
  Widget build(BuildContext context) {
    _registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            _RegisterTextWidget(
              registerText: _registerText,
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: PaddingConst.registerPaddingTextView,
              child: _loginTextFormField(context),
            ),
            Padding(
                padding: PaddingConst.buttonPadding,
                child: _registerButton(context)),
          ],
        ),
      ),
    );
  }

  Form _loginTextFormField(BuildContext context) {
    return Form(
        key: _formState,
        child: Column(
          children: [
            _emailTextForm(),
            const SizedBox(
              height: 15,
            ),
            _passwordTextForm(),
            const SizedBox(
              height: 15,
            ),
            _passwordAgainTextForm(),
          ],
        ));
  }

  TextFormField _passwordTextForm() {
    return TextFormField(
      onSaved: (deger) {
        _registerProvider.setPasswordText = deger;
      },
      obscureText: _registerProvider.hidePassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: _passwordHintText,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: ColorConstance.focusColorTextForm),
          ),
          prefixIcon: IconConstance.passwordIcon,
          suffixIcon: IconButton(
              onPressed: () {
                //
                _registerProvider.hidePassword =
                    !_registerProvider.hidePassword;
              },
              icon: _registerProvider.hidePassword
                  ? IconConstance.hideText
                  : IconConstance.visibilityText)),
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre Boş kalınamaz";
        } else if (value.length < 6) {
          return "Şifre En 6 karakterli olması gerek";
        }
      },
    );
  }

  TextFormField _passwordAgainTextForm() {
    return TextFormField(
      onSaved: (deger) {
        _registerProvider.setPasswordAgainText = deger;
      },
      obscureText: _registerProvider.hidePasswordAgain,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: _passwordAgainText,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: ColorConstance.focusColorTextForm),
          ),
          prefixIcon: IconConstance.passwordIcon,
          suffixIcon: IconButton(
              onPressed: () {
                //
                _registerProvider.hidePasswordAgain =
                    !_registerProvider.hidePasswordAgain;
              },
              icon: _registerProvider.hidePasswordAgain
                  ? IconConstance.hideText
                  : IconConstance.visibilityText)),
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre Boş kalınamaz";
        } else if (value.length < 6) {
          return "Şifre En 6 karakterli olması gerek";
        }
      },
    );
  }

  TextFormField _emailTextForm() {
    return TextFormField(
      onSaved: (deger) {
        _registerProvider.setEmail = deger;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          hintText: _emailHintText,
          prefixIcon: IconConstance.emailIcon,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: ColorConstance.focusColorTextForm))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Email Boş Kalmamalı";
        } else if (!validateEmail(value)) {
          return "Geçersiz Email Girdiniz";
        }
      },
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  _dbRegister(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = _auth.currentUser!;
      if (user != null) {
        await user.sendEmailVerification();
        await _auth.signOut();
      }
    } catch (e) {
      print("Emial zaten kayıtlı");
    }
  }

  _registerButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formState.currentState!.validate()) {
            _formState.currentState!.save();

              _dbRegister(_registerProvider.getEmail.toString(),  // Firebase kayıt ediyor kullanıcıyı
                  _registerProvider.getPasswordAgainText.toString());
              Navigator.of(context).pushNamed(login);
  
          }
           if (!_registerProvider.passwordText
                .toString()
                .contains(_registerProvider.passwordAgainText.toString())) {
              print("Şifreler Aynı Değil");
              _formState.currentState!.reset();
            } 
        },
        style: ElevatedButton.styleFrom(
            onPrimary: ColorConstance.white,
            primary: ColorConstance.bgButton,
            shape: StadiumBorder()),
        child: Text(
          "KAYIT OL",
          style: TextStyle(fontSize: 18),
        ));
  }
}

class _RegisterTextWidget extends StatelessWidget {
  const _RegisterTextWidget({
    Key? key,
    required String registerText,
  })  : _registerText = registerText,
        super(key: key);

  final String _registerText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        _registerText,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            fontWeight: FontWeight.bold, color: ColorConstance.loginTextColor),
      ),
    );
  }
}
