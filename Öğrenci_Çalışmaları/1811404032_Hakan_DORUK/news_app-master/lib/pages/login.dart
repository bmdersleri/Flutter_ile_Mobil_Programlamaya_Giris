import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/constance/colors.dart';
import 'package:news_app/constance/icons.dart';
import 'package:news_app/constance/padding.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/viewmodel/login.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginText = "Giriş Yap";
  final _emailHintText = "Email Giriniz";
  final _passwordHintText = "Şifrenizi Giriniz";
  final _formState = GlobalKey<FormState>();
  late LoginProvider _loginProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        if (user.emailVerified) {
          Navigator.of(context).pushNamed(home);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginProvider = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 130,
              ),
              _LoginTextWidget(loginText: _loginText),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: PaddingConst.loginPaddingTextView,
                child: _loginTextFormField(context),
              ),
              Padding(
                padding: PaddingConst.buttonPadding,
                child: _loginButton(context),
              ),
              const SizedBox(
                height: 15,
              ),
              _LoginReegisterText(), // Üye değilse üye sayfasına gitmesi için,

              const SizedBox(
                height: 20,
              ),
              _loginWithGoogle(context),
            ],
          ),
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
            _passwordTextForm()
          ],
        ));
  }

  TextFormField _passwordTextForm() {
    return TextFormField(
      onSaved: (deger) {
        _loginProvider.setPassword = deger;
      },
      obscureText: _loginProvider.hidePassword,
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
                _loginProvider.hidePassword = !_loginProvider.hidePassword;
              },
              icon: _loginProvider.hidePassword
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
        _loginProvider.email = deger;
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

  _loginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formState.currentState!.validate()) {
            _formState.currentState!.save();
            _dbLogin(_loginProvider.email.toString(),
                _loginProvider.getPassword.toString());
            Navigator.of(context).pushNamed(home);
          }
        },
        style: ElevatedButton.styleFrom(
            onPrimary: ColorConstance.white,
            primary: ColorConstance.bgButton,
            shape: StadiumBorder()),
        child: Text(
          "GİRİŞ YAP",
          style: TextStyle(fontSize: 18),
        ));
  }

  _dbLogin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = _auth.currentUser!;
      if (user != null) {
        if (!user.emailVerified) {
          print("Email onaylı değil lütfen onaylayınız");
          await _auth.signOut();
        }
      }
    } catch (e) {
      print("Email veya şifre yanlış");
    }
  }

  // Google İle Giriş Metodu

  Future<UserCredential> signInWithGoogle() async {
    // google ile giriş işlemi yapıldı
    try {
      // Kimlik doğrulama akışını tetikliyoruz
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Yetkilendirme ayrıntılarını istekten alıyoruz
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Yeni bir kimlik bilgisi oluşturuyoruz
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Oturum açtıktan sonra, UserCredential'ı iade edin
      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (err) {
      // Handle err
      return Future.error("Hata");
    } catch (e) {
      var googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD);

      try {
        // Kullanıcının Google ile oturum açmasını deneyin
        await _auth.signInWithCredential(googleAuthCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // Hesap zaten farklı bir kimlik bilgisine sahip
          String email = e.email!;
          AuthCredential pendingCredential = e.credential!;

          // Çakışan kullanıcı için hangi oturum açma yöntemlerinin bulunduğunun bir listesini alın
          List<String> userSignInMethods =
              await _auth.fetchSignInMethodsForEmail(email);

          // Kullanıcının birkaç oturum açma yöntemi varsa, listedeki ilk yöntem kullanılması "önerilen" yöntem olacaktır.
          if (userSignInMethods.first == 'password') {
            // Kullanıcıdan şifresini girmesini isteyin
            String password = _loginProvider.getPassword.toString();

            // Kullanıcının hesabında parolayla oturum açın
            UserCredential userCredential =
                await _auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );

            // Bekleyen kimlik bilgilerini mevcut hesaba bağlayın
            await userCredential.user!.linkWithCredential(pendingCredential);
            // Başarı! Uygulama akışınıza geri dönün
            return goToApplication();
          }

          // Since other providers are now external, you must now sign the user in with another
          // auth provider, such as Facebook.
          if (userSignInMethods.first == 'facebook.com') {
            // Create a new Facebook credential
            String accessToken = await triggerFacebookAuthentication();
            var facebookAuthCredential =
                FacebookAuthProvider.credential(accessToken);

            // Sign the user in with the credential
            UserCredential userCredential =
                await _auth.signInWithCredential(facebookAuthCredential);

            // Link the pending credential with the existing account
            await userCredential.user!.linkWithCredential(pendingCredential);

            // Success! Go back to your application flow
            return goToApplication();
          }

          // Handle other OAuth providers...
        }
      }

      return Future.error("Böyle bir kullanıcı normal hesap olarak kayıtlı");
    }
  }

  Future<UserCredential> goToApplication() {
    // Futuru metod 0 sanıye duraklatıp bitirdik
    return Future.delayed(Duration.zero);
  }

  triggerFacebookAuthentication() {
    // Facebook accesToken yarattık
    return FacebookAuthProvider.FACEBOOK_SIGN_IN_METHOD;
  }

  _loginWithGoogle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: PaddingConst.loginPaddingTextView,
      child: ElevatedButton(
          onPressed: () {
            signInWithGoogle()
                .catchError((onError) => print(onError.toString()));
          },
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ),
          child: Text(
            "Google ile Giriş",
            style: TextStyle(fontSize: 18),
          )),
    );
  }
}

class _LoginReegisterText extends StatelessWidget {
  const _LoginReegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Hesabınız yoksa ",
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
          TextSpan(
              text: "üye olunuz",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, register);
                },
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ))
        ]));
  }
}

class _LoginTextWidget extends StatelessWidget {
  const _LoginTextWidget({
    Key? key,
    required String loginText,
  })  : _loginText = loginText,
        super(key: key);

  final String _loginText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        _loginText,
        style: Theme.of(context).textTheme.headline4?.copyWith(
            fontWeight: FontWeight.bold, color: ColorConstance.loginTextColor),
      ),
    );
  }
}
