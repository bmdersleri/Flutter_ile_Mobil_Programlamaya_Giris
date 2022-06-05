import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lisanstezistoktakipsistemi/screen/dashboard.dart';
import 'package:lisanstezistoktakipsistemi/screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
  const LoginScreen({Key? key}) : super(key: key);
}

class GradientText extends StatelessWidget {
   // ignore: use_key_in_widget_constructors
   const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}


class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey=GlobalKey<FormState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  String? enteredEmail,enteredPassword;

  Future<void> showErrorDialog(String text) async {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        //content: Text('Invalid Email/Password'),
        actions: <Widget>[
          TextButton(
            child: const Text('Tamam',style: TextStyle(
                          color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           const Center(
            child:  GradientText(
            'Stok Takip Sistemi',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,height:5),

            gradient: LinearGradient(colors: [
              Color(0xFF43CEA2),
              Color(0xFF185A9D),


            ]),
          ),

        ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key:loginFormKey,
                              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Align(alignment:Alignment.centerLeft,child:
                      Text('Giriş Yap',style: TextStyle(color: Color(0xFF43CEA2),fontWeight:FontWeight.bold,fontSize: 28),)),
                      const SizedBox(height:20),
                      TextFormField(
                        onChanged:(value){
                          enteredEmail=value;
                        },
                        cursorColor: const Color(0xFF185A9D),
                        decoration:  const InputDecoration(
                            border:  OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF185A9D)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF185A9D)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF43CEA2)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            hintStyle:  TextStyle(color: Color(0xFF185A9D)),
                            labelText: 'E-mail',
                            labelStyle: TextStyle(
                                fontSize: 20, color: Color(0xFF185A9D))),
                                validator: (email){
                                  if(email!.isEmpty) {
                                    return "Bu alan boş olamaz";
                                  } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                                    return "Geçerli bir e-posta giriniz";
                                  }
                                  return null;
                                },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged:(value){
                          enteredPassword=value;
                        },
                        cursorColor: const Color(0xFF185A9D),
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF185A9D)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF185A9D)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF43CEA2)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            hintStyle: TextStyle(color:Color(0xFF185A9D)),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontSize: 20, color: Color(0xFF185A9D))),
                                validator: (password){
                                  if(password!.isEmpty) {
                                    return "Bu alan boş olamaz";
                                  } else if(password.length<8){
                                    if (!RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(password)) {
                                      return "Geçersiz şifre";
                                    }}
                                  return null;
                                },
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if(loginFormKey.currentState!.validate()) {
                            _auth.signInWithEmailAndPassword(email: enteredEmail!, password: enteredPassword!)
                          .then((value)
                              {
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                              (route) => false);

                              }
                          ).catchError((onError){
                            showErrorDialog(onError.code=='Hata çok fazla istek var'?'Server hatası. Daha sonra tekrar deneyin':'Geçersiz E-posta/Parola');
                            if (kDebugMode) {
                              print(onError.code);
                            }
                            });
                          }
                          OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(color: Color(0xFF185A9D)),
                            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: const Color(0xFF185A9D),

                          ));
                        },






                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(
                                color: Color(0xFF185A9D), fontSize: 22,decorationColor: Color(0xFF35858B) ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Hesabınız yok mu?',style: TextStyle(color: Color(0xFF185A9D), fontSize: 18),),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                              },
                                                        child: const Text(
                                ' Üye ol',
                                style: TextStyle(color: Color(0xFF43CEA2),fontSize: 18),
                              ),
                            )
                          ],
                        ),
                       ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}