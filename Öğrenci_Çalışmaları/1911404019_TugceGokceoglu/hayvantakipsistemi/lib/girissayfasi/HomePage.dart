import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hayvantakipsistemi/model/asilamabilgileri/asilamaekle.dart';
import 'package:hayvantakipsistemi/model/hastalikbilgileri/hastalikekle.dart';
import 'package:hayvantakipsistemi/model/hayvanekle.dart';
import 'package:hayvantakipsistemi/model/tohumlamasayfasi/tohumlamaekle.dart';

class HomePages extends StatefulWidget {
  HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
bool? _hayvanvar;

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    // TODO: implement initState
    _hayvanvarSorgula();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SingleChildScrollView(
          child: Row(
            children: [
              Text(
                  _auth.currentUser!.displayName != null
                      ? _auth.currentUser!.displayName!
                      : "Hoşgeldiniz",
                  style: TextStyle(
                      color: Color(0xFF375BA3),
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              Spacer(),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.info_outline,
                    color: Color(0xFF375BA3),
                    size: 26,
                  ),
                  onPressed: () => showInfo(context)),
              IconButton(
                  onPressed: () {
                    _cikisYap(context);
                    Navigator.pushNamed(context, '/girissayfasi');
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Color(0xFF375BA3),
                  )),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Color(0xFF375BA3),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Hızlı İşlem",
                  style: TextStyle(
                      color: Color(0xFF375BA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildcontainericon(
                    context: context,
                    baslik: "Hayvan Ekle",
                    icon: Icon(Icons.add, color: Color(0xFF375BA3)),
                    sayfaismi: "Hayvan Ekle",
                    sayfa: HayvanEkleModal(
                      hayvanekeklendi: _hayvanvar,
                    )),
                buildcontainericon(
                  context: context,
                  baslik: "Hastalık Ekle",
                  icon: Icon(Icons.sick_rounded, color: Color(0xFF375BA3)),
                  sayfaismi: "Hastalık Ekle",
                  sayfa: HastalikEkleModal(sayfayonlendir: false),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildcontainericon(
                    context: context,
                    baslik: "Aşılama Ekle",
                    icon: FaIcon(FontAwesomeIcons.syringe,
                        color: Color(0xFF375BA3)),
                    sayfaismi: "Aşılama Ekle",
                    sayfa: Asilama(
                      sayfayonlendir: false,
                    )),
                buildcontainericon(
                    context: context,
                    baslik: "Tohumlama Ekle",
                    icon: FaIcon(FontAwesomeIcons.seedling,
                        color: Color(0xFF375BA3)),
                    sayfaismi: "Tohumlama Ekle",
                    sayfa: TohumalamaEkleModal(
                      sayfayonlendir: false,
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.library_books_sharp,
                  color: Color(0xFF375BA3),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Sayfalar",
                  style: TextStyle(
                      color: Color(0xFF375BA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildcontainer(
                  context,
                  "/hayvanlarim",
                  " Hayvanlarım",
                  FaIcon(FontAwesomeIcons.cow, color: Color(0xFF30A0BD)),
                ),
                SizedBox(
                  width: 16,
                ),
                buildcontainer(
                  context,
                  "/asilama",
                  "Aşılama",
                  FaIcon(FontAwesomeIcons.syringe, color: Color(0xFF30A0BD)),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildcontainer(
                  context,
                  "/hastalik",
                  " Hastalık",
                  Icon(Icons.sick_rounded, color: Color(0xFF30A0BD)),
                ),
                SizedBox(
                  width: 16,
                ),
                buildcontainer(
                  context,
                  "/tohumlama",
                  " Tohumlama",
                  FaIcon(FontAwesomeIcons.syringe, color: Color(0xFF30A0BD)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

buildcontainer(BuildContext context, String text, String text1, icon) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, text);
      },
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, text);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(top: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, text);
                            },
                            icon: Center(
                              child: icon,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, text);
                          },
                          child: Text(
                            text1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
    ),
  );
}

buildcontainericon(
    {context,
    required String baslik,
    required icon,
    required String sayfaismi,
    required sayfa}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        title: Text(
                          sayfaismi,
                          style: TextStyle(
                            color: Color(0xFF375BA3),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                            color: Color(0xFF375BA3),
                          )
                        ],
                        elevation: 0,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: sayfa,
                      ),
                    ),
                  ));
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(34),
              gradient: LinearGradient(
                colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white.withOpacity(0.8),
              size: 35,
            ),
          );
        },
        child: Container(
          width: 165,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Color(0xFF375BA3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(child: icon),
                ),
              ),
              SizedBox(
                height: 2,
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  baslik,
                  style: TextStyle(
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _cikisYap(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}

Future _hayvanvarSorgula() async {
  Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
      .collection('kullanicilar')
      .doc(kullaniciId)
      .collection('hayvanlar');
  QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

  if (snapshot.docs.isNotEmpty) {
    _hayvanvar = true;
  } else {
    _hayvanvar = false;
  }
}


showInfo(BuildContext context) {
  return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          
          title: const Text('Hakkımda',style: TextStyle(color: Color(0xFF375BA3) , fontWeight: FontWeight.bold),),
          content: Container(
            height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Adı - Soyadı",style: TextStyle(color: Color(0xFF375BA3) , fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Text("Tuğçe Gökçeoğlu"),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Okul - Numarası",style: TextStyle(color: Color(0xFF375BA3) , fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Text("1911404019"),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Email",style: TextStyle(color: Color(0xFF375BA3) , fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Text("tgcegkceoglu4@gmail.com"),
                    ],
                  ),
                ),
              ],
                    ),
            ),
          ),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam',style: TextStyle(color: Color(0xFF375BA3) , fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      );
}
