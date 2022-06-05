import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lisanstezistoktakipsistemi/screen/dashboard.dart';
import 'package:lisanstezistoktakipsistemi/screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);



  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
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
class _SignUpScreenState extends State<SignUpScreen> {
  final signupFormKey=GlobalKey<FormState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  String? enteredBusinessName,enteredEmail,enteredMobileNumber,enteredPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Center(
                  child:  Center(
                    child: GradientText(
                      'Stok Takip Sistemi',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,height:5),
                      gradient: LinearGradient(colors: [
                        Color(0xFF43CEA2),
                        Color(0xFF185A9D),
                      ]),
                    ),
                  ),

                ),
                Form(
                  key:signupFormKey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Align(alignment:Alignment.centerLeft,child: Text('Bir hesap oluşturun',style: TextStyle(color:Color(0xFF43CEA2),fontWeight:FontWeight.bold,fontSize: 28),)),
                          const SizedBox(height:18),
                          TextFormField(
                            onFieldSubmitted: (value){
                              FocusScope.of(context).nextFocus();
                            },
                            textInputAction: TextInputAction.next,
                            cursorColor: const Color(0xFF43CEA2),
                            decoration:InputDecoration(
                                border:const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF43CEA2)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle:TextStyle(color: Colors.grey[800]),
                                labelText: 'Şirket İsmi',
                                labelStyle: const TextStyle(
                                    fontSize: 20, color: Color(0xFF185A9D))),
                                    // ignore: missing_return
                                    validator: (businessName){
                                      if(businessName!.isEmpty) {
                                        return  "Bu alan boş olamaz";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                      enteredBusinessName=value;
                                    },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onFieldSubmitted: (value){
                              FocusScope.of(context).nextFocus();
                            },

                            textInputAction: TextInputAction.next,
                            cursorColor: const Color(0xFF43CEA2),
                            decoration:InputDecoration(
                                border:const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF43CEA2)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle:TextStyle(color: Colors.grey[800]),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                    fontSize: 20, color: Color(0xFF185A9D))),
                                // ignore: missing_return
                                validator: (email){
                                      if(email!.isEmpty) {
                                        return  "Bu alan boş olamaz";
                                      } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                                        return "Geçerli bir e-posta giriniz";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                      enteredEmail=value;
                                    },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                              flex:1,
                                child: TextFormField(
                                enabled: false,
                              cursorColor: const Color(0xFF185A9D),
                              decoration:InputDecoration(
                                  border:const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF185A9D)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color:Color(0xFF185A9D)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF185A9D)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF43CEA2)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  hintStyle:TextStyle(color: Colors.grey[800]),
                                  labelText: '+90',
                                  labelStyle: const TextStyle(
                                      fontSize: 20, color: Color(0xFF185A9D))),
                          ),
                            ),
                            const SizedBox(width: 10),
                          Expanded(
                            flex:4,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    onFieldSubmitted: (value){
                              FocusScope.of(context).nextFocus();
                            },
                            textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                              cursorColor: const Color(0xFF185A9D),
                              decoration:InputDecoration(
                                  border:const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color:Color(0xFF185A9D)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF185A9D)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color:Color(0xFF43CEA2)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  hintStyle:TextStyle(color: Colors.grey[800]),
                                  labelText: 'Telefon Numarası',
                                  labelStyle: const TextStyle(
                                      fontSize: 20, color: Color(0xFF185A9D))),
                                      // ignore: missing_return
                                      validator: (mobNo){
                                        if(mobNo!.isEmpty) {
                                          return "Bu alan boş olamaz";
                                        } else if(mobNo.length<10) {
                                          return "Geçerli  10 basamaklı bir numara girin";
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        enteredMobileNumber=value;
                                      },
                            ),
                          ),
                          ],),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onFieldSubmitted: (value){
                              FocusScope.of(context).nextFocus();
                            },
                            textInputAction: TextInputAction.next,
                            cursorColor: const Color(0xFF185A9D),
                            obscureText: true,
                            decoration:InputDecoration(
                                border:const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color:Color(0xFF43CEA2)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle:TextStyle(color: Colors.grey[800]),
                                labelText: 'Şifre',
                                labelStyle: const TextStyle(
                                    fontSize: 20, color: Color(0xFF185A9D))),
                                  // ignore: missing_return
                                  validator: (password){
                                  if(password!.isEmpty) {
                                    return "Bu alan boş olamaz";
                                  } else if(password.length<8){
                                    if (RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(password)) {
                                      return "Şifre çok zayıf";
                                    }
                                  }
                                  return null;
                                },
                                onChanged: (value){
                                  enteredPassword=value;
                                },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            cursorColor: const Color(0xFF185A9D),
                            obscureText: true,
                            onFieldSubmitted: (value){
                              FocusScope.of(context).nextFocus();
                            },
                            decoration:InputDecoration(
                                border:const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF185A9D)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF43CEA2)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle:TextStyle(color: Colors.grey[800]),
                                labelText: 'Şifreyi Onayla',
                                labelStyle:  const TextStyle(
                                    fontSize: 20, color: Color(0xFF185A9D))),
                                     // ignore: missing_return
                                     validator: (confirmPassword){
                                  if(confirmPassword!.isEmpty) {
                                    return "Bu alan boş olamaz";
                                  } else if(confirmPassword!=enteredPassword) {
                                    return "Bu alan boş olamaz";
                                  }
                                  return null;
                                },
                          ),
                           const SizedBox(
                            height: 22,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              if(signupFormKey.currentState!.validate()) {
                                _auth.createUserWithEmailAndPassword(email: enteredEmail!, password: enteredPassword!).then((value){
                                  FirebaseFirestore.instance
                                  .collection('BusinessDetails').doc(value.user!.uid).set({
                                    'businessName':enteredBusinessName,
                                    'contactNumber':enteredMobileNumber,
                                    'email':enteredEmail,

                                  }).then((value){
                                    Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard()),
                                  (route) => false);
                                  });
                                });
                              }

                              OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF185A9D)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor : Colors.white,
                              ));

                            },



                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 18),
                              child: Text(
                                'Üye ol',
                                style: TextStyle(
                                    color: Color(0xFF185A9D), fontSize: 22),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('Zaten hesabınız var mı?',style: TextStyle(color: Color(0xFF185A9D)),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                                  },
                                   child: const Text(
                                    ' Giriş yap',
                                    style: TextStyle(color: Color(0xFF43CEA2)),
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
        ),
      ),
    );
  }
}