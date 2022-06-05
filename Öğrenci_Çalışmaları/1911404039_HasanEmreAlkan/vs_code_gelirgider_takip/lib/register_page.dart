import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vs_code_gelirgider_takip/main.dart';
import 'input_page.dart';


class Register extends StatefulWidget {
  final Function() onClickedSignIn;
  const Register({Key? key,required this.onClickedSignIn}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? password;
  final _textcontrollerEmail = TextEditingController();
  final _textcontrollerPassword = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:100,left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: InputPage.primaryColor)),
                    labelText: "Email",
                    labelStyle: GoogleFonts.roboto(color: InputPage.primaryColor),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Email";
                    } else
                      return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                  controller: _textcontrollerEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: InputPage.primaryColor)),
                    labelText: "Password",
                    labelStyle: GoogleFonts.roboto(color: InputPage.primaryColor),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8 || value.length > 16) {
                      return "The length of your password must be between 8 and 16!";
                    } else
                      return null;
                  },
                  onSaved: (value) {
                    password = value;
                  },
                  controller: _textcontrollerPassword,
                ),
                ElevatedButton(
                  onPressed: signUp,
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.roboto(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20,),
                RichText(text: TextSpan(
                  style: TextStyle(color: Colors.black,fontSize: 18,),
                  text: 'Already have an acoount?',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
                      text: 'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        color: Colors.redAccent
                      )
                    ),
                  ],
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async{
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>Center(child: CircularProgressIndicator(),));
    try{
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _textcontrollerEmail.text,
          password: _textcontrollerPassword.text);

      await _firestore.collection('users').doc(user.user!.uid).set({
        'id':user.user!.uid,
        'email':_textcontrollerEmail.text,
        'password' : _textcontrollerPassword.text,
      });
    } on FirebaseAuthException catch (e){
      print(e);
    }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
