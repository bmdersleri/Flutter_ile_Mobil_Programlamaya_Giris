import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var email;
  var sifre;
  final _formKey = GlobalKey<FormState>();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      child: Text("Üye Ol"),
                      textColor: Colors.purple,
                      onPressed: (){
                        Navigator.pushNamed(context, 'register');
                      },
                    ),
                    MaterialButton(
                      child: Text("Şifremi Unuttum"),
                      textColor: Colors.purple,
                      onPressed: (){},
                    ),
                  ],
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
      child: Text("Giriş Yap"),
      color: Colors.lightBlueAccent,
      textColor: Colors.purple,
      onPressed: (){

        if(_formKey.currentState!.validate()){
          _formKey.currentState!.save();
          if(email=="admin" && sifre=="admin"){
            Navigator.pushNamed(context, 'anasayfa');
          }
          else{
             showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Hata"),
                content: Text("Giriş Bilgileriniz Hatalı"),
                actions: <Widget>[
                  MaterialButton(
                      child: Text("Geri Dön"),
                      onPressed:()=>Navigator.pop(context)
                  ),
                ],
              ),
            );
          }
        }

      });
}
