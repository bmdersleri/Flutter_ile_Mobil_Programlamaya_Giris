import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetlogin/screen/about_us.dart';
import 'package:vetlogin/screen/selectionScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState  createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formPass = GlobalKey<FormState>(); 
  final _formUser = GlobalKey<FormState>();

  TextEditingController username = TextEditingController(); //kullanıcı ismini kontrol etmek için bir conroller tanımlıyoruz
  TextEditingController password = TextEditingController();//kullanıcı şifresini kontrol etmek için bir conroller tanımlıyoruz

   bool isHidden = true; //şifre kısmında gizli tutmak için bir değişken tanımlayıp değerini true olarak belirliyoruz.
  togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  bool isRememberMe = false;
  List<String> items = [];

  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Childrenler eksen boyunca nasıl yerleştirilceğini belirtlir.
        children: <Widget>[
          const Text(
            'E-mail',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),//textin stilini ayarlıyoruz.
          ),
          const SizedBox(height: 10), // alt boşluk vermek için kullanıyoruzz
          Container(
            alignment: Alignment.centerLeft, // hizalama için kullanıyoruz.
            decoration: BoxDecoration( // kutuya stil, şekil vermek için kullanıyoruz.
                color: Colors.white, // rengini belirmekteyiz.
                borderRadius: BorderRadius.circular(10), //kenar kısmına ovallik veriyoruz.
                boxShadow: const [ // kutuya gölge veriyoruz.
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,//bulanıklık değeri belirliyoruz.
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Form(
              key: _formUser,
              child: TextFormField( //bir metin form alanı veriyoruz
                obscureText: false, //görünürlüğünü açık olarak belirtiyoruz.
                controller: username,
                keyboardType: TextInputType.emailAddress, // e posta adresleri için optimize ediyoruz
                style: TextStyle(color: Colors.black87), // yazı stilini belirliyoruz.
                decoration: InputDecoration( //kutuya stil, şekil vermek için kullanıyoruz.
                    border: InputBorder.none, // kenarlık çizilmemesi gerektiğini belirtiyoruz.
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon( // text girilen yerden önce görünen simge eklemek için kullanıyoruz.
                      Icons.email,// bir e-mail ikonu seçelim.
                      color: Color(0xff2c2772),//icon rengini belirleyebiliyoruz.
                    ),
                    hintText: 'E-mail', //ipucu metini ekleyebiliyoruz. Kullanıcı buraya text girdiğinde silinmektedir.
                    hintStyle: TextStyle(color: Colors.black38)),//ipucu metninin style nı belirleyebiliyoruz.
                validator: (value) { // burada birk kontrol yapımız var
                  if (value == null || value.isEmpty) { //
                    return '   Lütfen bir kullanıcı adınızı giriniz';// kullanıcı adı girilmediğinde verilecek mesaj
                  } else if (value.length < 4) {
                    return "   Kullanıcı adı en az 4 karakter olmalıdır";// kullanıcı adı 4 karakterden az olduğunda verilecek mesaj
                  } else if (value.length > 22) { // kullanıcı adı 22verilecek mesaj karakterden fazla olduğunda 
                    return "   Kullanıcı adı 22 karakterden uzun olmamalıdır";
                  }
                  return null;
                },
              ),
            ),
          )
        ]);
  }

  Widget buildPassword(isHidden) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Şifre',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Form(
              key: _formPass,
              child: TextFormField(
                obscureText: true, // şifre girildiğinden dolayı metni gizli tutuyoruz.
                style: TextStyle(color: Colors.black87),
                controller: password,
               //    obscureText: isHidden,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: togglePasswordVisibility,
                                  ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff2c2772),
                    ),
                    hintText: 'Şifre',
                    hintStyle: TextStyle(color: Colors.black38)),
                validator: (value) {
                  if (value == null || value.isEmpty) {// şifre için bir kontrol yapımız bulunmakta
                    return 'Lütfen  parolanızı giriniz';//parolo girilmediğinde verilecek mesaj
                  } else if (value.length < 4) {
                    return "Şifre en az 6 karakter olmalıdır";
                  } else if (value.length > 15) {
                    return "Şifre 15 karakterden uzun olmamalıdır";
                  }
                  return null;
                },
              ),
            ),
          )
        ]);
  }

  Widget buildForgotPassBtn() {
    return Container(
      
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: (){
      
  Navigator.push(
   this.context,
    MaterialPageRoute(builder: (context) =>  Profil()),//profil adı verilen sayfaya yönlendirme yapılmaktadır.
  );
},
        child: const Center( // yazıyı ortalamak için center içine alıyoruz.
          child: Text(
            'Hakkımızda',
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,// hakkımızda yazısının kalın gözükmesini sağlamaktadır.
              fontSize: 22,// yazı boyutunu belirtiyoruz.
              
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigator.push(
          //   this.context,
          //   MaterialPageRoute(
          //     builder: (context) => RegisterScreen(),
          //   ),
          // );
        },
        child: const Center(
          child: Text(
            'Kayıt Ol',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(// onay kutusu ekliyoruz
            value: isRememberMe,
            checkColor: Colors.indigo,// tıklandığında onay ifadesinin rengini belirleyebiliyoruz.
            activeColor: Colors.white,// tıklandığında arka plan rengini belirleyebiliyoruz.
            onChanged: (value) {
              setState(() {
                isRememberMe = value!;
              });
            },
          ),
        ),
        const Text('Beni Hatırla',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
      ]),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: double.infinity,
      child: ElevatedButton( //giriş yap butonu için bir elevated button ekliyoruz.
        
        onPressed: () {  
          bool passflag = false;
          bool userflag = false;
          if (_formPass.currentState!.validate())
            {
              passflag = true;
            }
          else
            {print("_formPass.currentState true");}
          if (_formUser.currentState!.validate()) {
            userflag = true;
          } else {
            print("_formUser.currentState true");
          }
          if (userflag && passflag) {
            Navigator.push(
              this.context,
              MaterialPageRoute(//ekranı plaforma uyarlanabilir bir geçişle değiştirir.
                builder: (context) => SelectionScreen(items),
              ),
            );
          }
        },
        child: const Text(
          'GİRİŞ YAP',
          style: TextStyle(
            color: Color(0xff2c2772),
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(// kçşeleri yuvarlatılmış bir dikdörtgen çizmek için kullanıyoruz.
            borderRadius: BorderRadius.circular(15),
            // <-- Radius
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool passflag;
    bool userflag;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastitis Tahlil Uygulaması'), // appbar en üst kısımda bulunan ve açıklama netni sunan yerdir. uygulama çubuğuda diyebiliriz.
      ),
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.png"),// uygulamanın arka planını ekliyoruz.
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage(
                          'assets/haytek_beyaz.png', //burada giriş sayfamızdabulunan logomuzu ekliyoruz.
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Veteriner Hekim Giriş ',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildEmail(),
                      const SizedBox(height: 15),
                      buildPassword(true),
                      const SizedBox(height: 20),
                      buildRememberCb(),
                      const SizedBox(height: 30),
                      buildLoginBtn(),
                      buildForgotPassBtn(),
                      const SizedBox(height: 1),
                      buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
