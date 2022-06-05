import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vs_code_gelirgider_takip/main.dart';

import 'input_page.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({Key? key,required this.onClickedSignUp}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? userName;
  String? password;
  final _textcontrollerEmail = TextEditingController();
  final _textcontrollerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:20,left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/gelir.png'),),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: InputPage.primaryColor)),
                      labelText: "Email",
                      labelStyle:
                          GoogleFonts.roboto(color: InputPage.primaryColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email adresinizi giriniz!";
                      } else
                        return null;
                    },
                    onSaved: (value) {
                      userName = value;
                    },
                    controller: _textcontrollerEmail,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: InputPage.primaryColor)),
                      labelText: "Sifre",
                      labelStyle:
                          GoogleFonts.roboto(color: InputPage.primaryColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Sifrenizi giriniz!";
                      } else
                        return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                    controller: _textcontrollerPassword,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(elevation: MaterialStateProperty.all(10)),
                      onPressed: signIn,
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.roboto(fontSize:20,color: Colors.black54),
                      ),
                    ),SizedBox(height: 25,),
                    Center(
                      child: RichText(
                        text: TextSpan(
                        style: TextStyle(color:Colors.black,fontSize: 20),
                          text: 'No Account',
                         children: [
                           TextSpan(
                             recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                             text: 'Sign Up',
                             style : TextStyle(
                                 decoration: TextDecoration.underline,
                                 color: Colors.red,
                             ),
                           ),
                         ],
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _textcontrollerEmail.text,
          password: _textcontrollerPassword.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}
