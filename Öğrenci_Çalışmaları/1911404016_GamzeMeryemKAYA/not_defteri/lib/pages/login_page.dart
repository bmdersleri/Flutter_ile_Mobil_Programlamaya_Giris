import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _girisFormKey = GlobalKey<FormState>();
  final _kayitKey = GlobalKey<FormState>();
  final _sifreSifirlamaKey = GlobalKey<FormState>();

  final TextEditingController _emailGirisController = TextEditingController();
  final TextEditingController _sifreGirisController = TextEditingController();
  final TextEditingController _emailKayitController = TextEditingController();
  final TextEditingController _sifreKayitController = TextEditingController();
  final TextEditingController _sifreSifirlamaEmailController =
      TextEditingController();

  late FirebaseAuth _auth;

  @override
  void dispose() async {
    _emailGirisController.dispose();
    _sifreGirisController.dispose();
    _emailKayitController.dispose();
    _sifreKayitController.dispose();
    _sifreSifirlamaEmailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User oturumu kapalı!');
      } else {
        if (mounted) {
          debugPrint(
              'User oturum açık ${user.email}');
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        //key: _scaffold,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Login Ekranı'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 10),
          child: Form(
            key: _girisFormKey,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-mail boş bırakılamaz';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Geçerli bir e-mail adresi girin';
                    } else {
                      return null;
                    }
                  },
                  controller: _emailGirisController,
                  decoration: InputDecoration(
                      label: const Text('E-mail'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const Expanded(child: SizedBox()),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Şifre boş bırakılamaz';
                    } else if (value.length < 6) {
                      return 'Şifre en az 6 karakter olmalı';
                    } else {
                      return null;
                    }
                  },
                  controller: _sifreGirisController,
                  decoration: InputDecoration(
                      label: const Text('Şifre'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {
                      if (_girisFormKey.currentState!.validate()) {
                        loginUserEmailandPassword();
                      }
                    },
                    child: const Text('Giriş Yap')),
                TextButton(
                    onPressed: () {
                      kayitOl();
                    },
                    child: const Text('Kayıt Ol')),
                TextButton(
                    onPressed: () {
                      sifremiUnuttum();
                    },
                    child: const Text('Şifremi Unuttum')),
                const Expanded(flex: 10, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void kayitOl() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kayıt Ol'),
          content: Form(
              key: _kayitKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailKayitController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Boş bırakılamaz.';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Geçerli bir e-mail adresi girin.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          label: const Text('E-Mail'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    TextFormField(
                      controller: _sifreKayitController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Boş bırakılamaz.';
                        } else if (value.length < 6) {
                          return 'Şifre en az 6 karakter olmalı';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          label: const Text('Şifre'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ],
                ),
              )),
          actions: <Widget>[
            TextButton(
              child: const Text('Vazgeç'),
              onPressed: () {
                _emailKayitController.clear();
                _sifreKayitController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_kayitKey.currentState!.validate()) {
                    emailSifreileKayitOlustur();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: const Text('Eksik bilgi girdiniz.'),
                    )));
                  }
                },
                child: const Text('KAYDET'))
          ],
        );
      },
    );
  }

  void emailSifreileKayitOlustur() async {
    try {
      var hesap = await _auth.createUserWithEmailAndPassword(
          email: _emailKayitController.text.trim(),
          password: _sifreKayitController.text.trim()).whenComplete(() {
            _emailKayitController.clear();
      _sifreKayitController.clear();
            Navigator.of(context).pop();
          });
      
      
      
      await _auth.signOut().whenComplete(
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false),
          );
      debugPrint(hesap.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:
                    const Text('Bu mail adresi ile daha önce kayıt oluşturulmuş.'),
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text('Tamam'))
                ],
              );
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Bir hata oluştu daha sonra tekrar deneyin.')));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sifremiUnuttum() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _sifreSifirlamaEmailController.text = '';
                  },
                  child: const Text('Vazgeç')),
              ElevatedButton(
                  onPressed: () async {
                    sifreSifirlamaMailiGonder();
                  },
                  child: const Text('Tamam'))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Şifrenizi sıfırlamak için mail adresinizi girin.'),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Form(
                  key: _sifreSifirlamaKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-Mail boş bırakılamaz.';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Geçerli bir e-mail adresi girin.';
                      } else {
                        return null;
                      }
                    },
                    controller: _sifreSifirlamaEmailController,
                    decoration: InputDecoration(
                        label: const Text('E-mail'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                )
              ],
            ),
            title: const Text('Şifremi Unuttum'),
          );
        });
  }

  void sifreSifirlamaMailiGonder() async {
    if (_sifreSifirlamaKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(
            email: _sifreSifirlamaEmailController.text.trim()).whenComplete(() {
              Navigator.pop(context);
        _sifreSifirlamaEmailController.text = '';
        
            }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Şifre sıfırlama maili gönderildi.'),
        ))));

        
        
      } on FirebaseAuthException catch (e) {
        debugPrint(e.code);
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Bu e-mail ile kayıtlı kullanıcı yok.'),
          )));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Geçerli bir e-mail adresi girin.'),
          )));
        }
      }
    }
  }

  Future<void> loginUserEmailandPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailGirisController.text.trim(),
          password: _sifreGirisController.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Bu e-mail ile kayıtlı kullanıcı yok.'),
        )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Şifreyi yanlış girdiniz.'),
        )));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Geçerli bir e-mail adresi girin.'),
        )));
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail veya şifre yanlış girildi.')));
    }
  }
}
