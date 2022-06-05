import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/tohumlama.dart';
import 'package:hayvantakipsistemi/model/bilgiler.dart';

class RefreshTohumlama extends StatefulWidget {
  const RefreshTohumlama({ Key? key }) : super(key: key);

  @override
  State<RefreshTohumlama> createState() => _RefreshTohumlamaState();
}
TextEditingController _arama = TextEditingController();
List<TohumlamaEkleFirebase> _tohumlamaverileri = [];
List<HayvanEkleFirebase> _hayvanverileri = [];
FirebaseAuth _auth = FirebaseAuth.instance;
bool _aramabool = false;
class _RefreshTohumlamaState extends State<RefreshTohumlama> {
   @override
  void initState() {
    // TODO: implement initState
    _tohumlamaverileri = [];
    _hayvanverileri = [];
    _arananHayvan = [];
    _arananTohumlama = [];
    _aramabool = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                width: 1,
                color: Color(0xFF375BA3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                onChanged: (context) {
                  setState(() {
                    if (_arama.text.length == 0) {
                      _arananHayvan = [];
                      _arananTohumlama = [];
                      _aramabool = false;
                    } else {
                      _aramabool = true;
                      _arananTumHayvanlar();
                    }
                  });
                },
                controller: _arama,
                cursorColor: Color(0xFF375BA3),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  focusColor: Color(0xFF375BA3),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Color(0xFF375BA3),
                  suffixIconColor: Color(0xFF375BA3),
                  suffixIcon: Icon(Icons.search, color: Color(0xFF375BA3)),
                  hintText:
                      "Tohumlama Bilgisini Aramak İstediğiniz Hayvanın Küpe Numarası",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
          _aramabool == false
              ? Expanded(
                  child: FutureBuilder(
                    future: readTumHayvanlar(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Bir Hata Oluştu - ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        final _hayvanlar = snapshot.data!;
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: _buildListView(context, snapshot));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
              : Expanded(
                  child: FutureBuilder(
                    future: _arananTumHayvanlar(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Bir Hata Oluştu - ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        final _hayvanlar = snapshot.data!;
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: _buildListViewArananHayvan(context, snapshot),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
        ],
      ),
    );
  }
}
Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapshot) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: _hayvanverileri.length,
          itemBuilder: _buildListTile,
        ),
      ),
    ],
  );
}

Widget _buildListTile(BuildContext context, int index) {
  return Bilgiler(
    deger: false,
    resim: _hayvanverileri[index].resim != null
        ? _hayvanverileri[index].resim
        : "https://firebasestorage.googleapis.com/v0/b/hayvantakipsistemi1.appspot.com/o/hayvanlar%2Finek.png?alt=media&token=c7dfd97c-42b3-4211-a523-273667d398dd",
    icon: Icon(Icons.sick_rounded, color: Color(0xFF375BA3)),
    icerik: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Küpe Numarası",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(_tohumlamaverileri[index].hayvaninkupeno)),
            ],
          ),
          Row(
            children: [
              Text(
                "Boğanın Küpe Numarası",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_tohumlamaverileri[index].boganinkupeno),
            ],
          ),
          Row(
            children: [
              Text(
                "Boğanın Irkı",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_tohumlamaverileri[index].boganinirki),
            ],
          ),
          Row(
            children: [
              Text(
                "Veteriner",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_tohumlamaverileri[index].tohumlamayiyapanvet),
            ],
          ),
          Row(
            children: [
              Text(
                "Tohumlama Başlangıç Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_tohumlamaverileri[index].tohumlamabaslangic.toString()),
            ],
          ),
          Row(
            children: [
              Text(
                "Tohumlama Bitiş Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_tohumlamaverileri[index].tohumlamabitis.toString()),
            ],
          ),
          _tohumlamaverileri[index].tohumlamanot != null
              ? Row(
                  children: [
                    Text(
                      "Not",
                      style: TextStyle(
                          color: Color(0xFF375BA3),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(_tohumlamaverileri[index].tohumlamanot),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}
Widget _buildListViewArananHayvan(
    BuildContext context, AsyncSnapshot<void> snapshot) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: _arananHayvan.length,
          itemBuilder: _buildListTileArananHayvan,
        ),
      ),
    ],
  );
}

Widget _buildListTileArananHayvan(BuildContext context, int index) {
  return Bilgiler(
    deger: false,
    resim: _arananHayvan[index].resim != null
        ? _arananHayvan[index].resim
        : "https://firebasestorage.googleapis.com/v0/b/hayvantakipsistemi1.appspot.com/o/hayvanlar%2Finek.png?alt=media&token=c7dfd97c-42b3-4211-a523-273667d398dd",
    icon: Icon(Icons.sick_rounded, color: Color(0xFF375BA3)),
    icerik: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Küpe Numarası",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(_arananTohumlama[index].hayvaninkupeno)),
            ],
          ),
          Row(
            children: [
              Text(
                "Boğanın Küpe Numarası",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananTohumlama[index].boganinkupeno),
            ],
          ),
           Row(
            children: [
              Text(
                "Boğanın Irkı",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananTohumlama[index].boganinirki),
            ],
          ),
           Row(
            children: [
              Text(
                "Veteriner",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananTohumlama[index].tohumlamayiyapanvet),
            ],
          ),

          Row(
            children: [
              Text(
                "Tohumlama Başlangıç Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananTohumlama[index].tohumlamabaslangic.toString()),
            ],
          ),
          Row(
            children: [
              Text(
                "Tohumlama Bitiş Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananTohumlama[index].tohumlamabitis.toString()),
            ],
          ),
          _arananTohumlama[index].tohumlamanot != null
              ? Row(
                  children: [
                    Text(
                      "Not",
                      style: TextStyle(
                          color: Color(0xFF375BA3),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(_arananTohumlama[index].tohumlamanot),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}


Future<List<dynamic>> readTumHayvanlar() async {
  Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
      .collection('kullanicilar')
      .doc(_auth.currentUser!.uid)
      .collection('hayvanlar');
  QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();
  if (snapshot.docs.isNotEmpty && sorgu != null) {
    for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
      Map<String, dynamic>? hayvanMap = dokuman.data();
      hayvanMap?["id"] = dokuman.id;
      if (hayvanMap != null) {
        Query<Map<String, dynamic>> sorgu1 = FirebaseFirestore.instance
            .collection('kullanicilar')
            .doc(_auth.currentUser!.uid)
            .collection('hayvanlar')
            .doc(dokuman.id)
            .collection('tohumlama');
        QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
        if (sorgu1 != null && snapshot1.docs.isNotEmpty) {
          QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
          if (snapshot1.docs.isNotEmpty) {
            for (DocumentSnapshot<Map<String, dynamic>> dokuman1
                in snapshot1.docs) {
              Map<String, dynamic>? hastalikMap = dokuman1.data();
              hastalikMap?["id"] = dokuman1.id;
              if (hastalikMap != null) {
                HayvanEkleFirebase hayvan =
                    HayvanEkleFirebase.fromJson(hayvanMap);
                _hayvanverileri.add(hayvan);
                TohumlamaEkleFirebase tohumlama =
                    TohumlamaEkleFirebase.fromJson(hastalikMap);
                _tohumlamaverileri.add(tohumlama);
              }
            }
          }
        }
      }
    }
  }
  return _hayvanverileri;
}

List<TohumlamaEkleFirebase> _arananTohumlama = [];
List<HayvanEkleFirebase> _arananHayvan = [];
Future<List<dynamic>> _arananTumHayvanlar() async {
  for (int i = 0; i < _hayvanverileri.length; i++) {
    if (_hayvanverileri[i].hayvaninkupeno == _arama.text) {
      if (_tohumlamaverileri[i].hayvaninkupeno == _arama.text) {
        _arananHayvan.add(_hayvanverileri[i]);
        _arananTohumlama.add(_tohumlamaverileri[i]);
      }
    }
  }
  _hayvanverileri = [];
  _tohumlamaverileri = [];
  return _hayvanverileri;
}
