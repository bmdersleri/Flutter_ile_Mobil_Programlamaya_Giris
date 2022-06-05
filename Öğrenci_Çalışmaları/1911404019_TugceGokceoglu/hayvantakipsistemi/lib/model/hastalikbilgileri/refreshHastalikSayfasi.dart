import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:hayvantakipsistemi/model/bilgiler.dart';

class RefreshHastalik extends StatefulWidget {
  RefreshHastalik({Key? key}) : super(key: key);

  @override
  State<RefreshHastalik> createState() => _RefreshHastalikState();
}

TextEditingController _arama = TextEditingController();
List<HastalikEkleFirebase> _hastalikverileri = [];
List<HayvanEkleFirebase> _hayvanverileri = [];
FirebaseAuth _auth = FirebaseAuth.instance;
bool _aramabool = false;

class _RefreshHastalikState extends State<RefreshHastalik> {
  @override
  void initState() {
    // TODO: implement initState
    _hastalikverileri = [];
    _hayvanverileri = [];
    _arananHayvan = [];
    _arananHastalik = [];
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
                      _arananHastalik = [];
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
                      "Hastalık Bilgisini Aramak İstediğiniz Hayvanın Küpe Numarası",
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
                  child: Text(_arananHastalik[index].hayvaninkupeno)),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalik İsmi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananHastalik[index].hastalikismi),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalık Başlangıç Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananHastalik[index].hastalikbaslangic.toString()),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalık Bitiş Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_arananHastalik[index].hastalikbitis.toString()),
            ],
          ),
          _arananHastalik[index].hastaliknot != null
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
                    Text(_arananHastalik[index].hastaliknot),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
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
                  child: Text(_hastalikverileri[index].hayvaninkupeno)),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalik İsmi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_hastalikverileri[index].hastalikismi),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalık Başlangıç Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_hastalikverileri[index].hastalikbaslangic.toString()),
            ],
          ),
          Row(
            children: [
              Text(
                "Hastalık Bitiş Tarihi",
                style: TextStyle(
                    color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(_hastalikverileri[index].hastalikbitis.toString()),
            ],
          ),
          _hastalikverileri[index].hastaliknot != null
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
                    Text(_hastalikverileri[index].hastaliknot),
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
            .collection('hastalik');
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
                HastalikEkleFirebase hastalik =
                    HastalikEkleFirebase.fromJson(hastalikMap);
                _hastalikverileri.add(hastalik);
              }
            }
          }
        }
      }
    }
  }
  return _hayvanverileri;
}

List<HastalikEkleFirebase> _arananHastalik = [];
List<HayvanEkleFirebase> _arananHayvan = [];
Future<List<dynamic>> _arananTumHayvanlar() async {
  for (int i = 0; i < _hayvanverileri.length; i++) {
    if (_hayvanverileri[i].hayvaninkupeno == _arama.text) {
      if (_hastalikverileri[i].hayvaninkupeno == _arama.text) {
        _arananHayvan.add(_hayvanverileri[i]);
        _arananHastalik.add(_hastalikverileri[i]);
      }
    }
  }
  _hayvanverileri = [];
  _hastalikverileri = [];
  return _hayvanverileri;
}
