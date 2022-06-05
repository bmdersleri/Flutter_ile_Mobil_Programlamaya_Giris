import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  var email;
  var sifre;
  final _formKey = GlobalKey<FormState>();
  bool _checked=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("resimler/background1.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: "İsim Soyisim",
                      labelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Lütfen İsim-Soyisim girin.";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    email=value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Lütfen mail girin.";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    email=value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: "Şifre",
                      labelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Lütfen şifre girin.";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    sifre=value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: "Şifre (Tekrar)",
                      labelStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder()),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Lütfen şifre girin.";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    sifre=value;
                  },
                ),
                _loginButton()
              ],
            ),
          ),

        ),
      ),
    );
  }
  Widget _loginButton()=>RaisedButton(
      child: Text("Kayıt Ol"),
      color: Colors.lightBlueAccent,
      textColor: Colors.purple,
      onPressed: (){
        Navigator.pushNamed(context, 'register');

      });
}
