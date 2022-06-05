import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/asilama.dart';
import 'package:hayvantakipsistemi/model/asilamabilgileri/refreshAsilama.dart';
import 'package:hayvantakipsistemi/model/takvimicon.dart';
import 'package:hayvantakipsistemi/model/textfieldarama.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';
import 'package:hayvantakipsistemi/view/asilamasayfasi.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:truncate/truncate.dart';

class Asilama extends StatefulWidget {
 bool sayfayonlendir;
 Asilama({Key? key,required this.sayfayonlendir}) : super(key: key);

  @override
  State<Asilama> createState() => _AsilamaState();
}

asilamakelime(String metin) {
  String text = metin;
  String yenimetin =
      truncate(text, 15, omission: "...", position: TruncatePosition.end);
  return yenimetin;
}

bool _textfieldkontrol = false;
CalendarFormat _format = CalendarFormat.month;
FirebaseAuth _auth = FirebaseAuth.instance;
DateTime _selectedDay = DateTime.now();
Veriler veri = Veriler();
DateTime _focusedDay = DateTime.now();
final _dateFormat = 'dd.MM.yyyy';
final _formattedDate = DateFormat(_dateFormat).format(DateTime.now());

class _AsilamaState extends State<Asilama> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  TextEditingController _hayvankupenocontroller = TextEditingController();
  TextEditingController _yapilacakasicontroller = TextEditingController();
  TextEditingController _asilayankisicontroller = TextEditingController();
  TextEditingController _asibaslangiccontroller =
      TextEditingController(text: _formattedDate);
  TextEditingController _asibitiscontroller =
      TextEditingController(text: _formattedDate);
  TextEditingController _asilamanot = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    
    _readTumHayvanlar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
          child: Container(
              padding: EdgeInsets.only(right: 35, left: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  textFieldKontrol();
                  if (_textfieldkontrol == true) {
                    createAsilama(
                      hayvaninkupeno: _hayvankupenocontroller.text,
                      yapilacakasi: _yapilacakasicontroller.text,
                      asilayankisi: _asilayankisicontroller.text,
                      asilamanot: _asilamanot.text,
                      asilamabaslangic: DateFormat(_dateFormat)
                          .parse(_asibaslangiccontroller.text),
                      asilamabitis: DateFormat(_dateFormat)
                          .parse(_asibitiscontroller.text),
                    
                    );
                    if(widget.sayfayonlendir==true){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AsilamaSayfasi()),).then((res) => RefreshAsilama());
                    }
                    else{
                      Navigator.pop(context);
                    }
                    
                  }
                  else{
                    startTimer("Boş Alan Bırakmayınız");
                  }
                },
                child: Text(
                  "Aşılamayı Ekle",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ))),
      body: ListView(
        children: [
          //Hayvanın Küpe Numarası Textfield
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchSelectPage(
                    inputType: TextInputType.number,
                    controller: _hayvankupenocontroller,
                    hinttext: "Hayvanın Küpe Numarasını Seçiniz...",
                    items: _hayvanlarkupeno,
                    selectedItem: _hayvankupenocontroller.text,
                    onSelection: (v) {
                      _hayvankupenocontroller.text = v;
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Color(0xFF375BA3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  enabled: false,
                  controller: _hayvankupenocontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Hayvanın Küpe Numarası",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Hayvana yapılan aşının Textfield
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchSelectPage(
                    inputType: TextInputType.text,
                    controller: _yapilacakasicontroller,
                    hinttext: "Aşı İsmini Giriniz...",
                    items: veri.asiismi,
                    selectedItem: _yapilacakasicontroller.text,
                    onSelection: (v) {
                      _yapilacakasicontroller.text = v;
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Color(0xFF375BA3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  enabled: false,
                  controller: _yapilacakasicontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Yapılacak Aşıyı Seçiniz",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //Aşılayan Kişinin Textfield
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Color(0xFF375BA3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _asilayankisicontroller,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Aşılayan Kişi",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
            ),
          ),
          TakvimIcon(
              controller: _asibaslangiccontroller,
              focusedDay: DateTime.now(),
              selectedDay: DateTime.now(),
              labeltext: "Aşılama Başlangıç Tarihi"),

          TakvimIcon(
              labeltext: "Aşılama Bitiş Tarihi",
              controller: _asibitiscontroller,
              focusedDay: _focusedDay,
              selectedDay: _selectedDay),

          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Color(0xFF375BA3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                cursorColor: Color(0xFF375BA3),
                maxLines: 5,
                controller: _asilamanot,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    labelText: "Eklemek İstediğiniz Not",
                    alignLabelWithHint: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 50;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 50) {
          _start--;
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            hinttext,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "lucida",
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            print(_start);
            _start--;
          });
        }
      },
    );
  }

  List<String> _hayvanlarkupeno = [];
  List<String> _hayvanIdleri = [];
  Future<List<dynamic>> _readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar')
        .where("hayvaninkupeno");

    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          HayvanEkleFirebase hayvan = HayvanEkleFirebase.fromJson(hayvanMap);
          _hayvanlarkupeno.add(hayvan.hayvaninkupeno);
          _hayvanIdleri.add(hayvan.hayvanId);
        }
      }
    }
    return _hayvanlarkupeno;
  }

  Future createAsilama({
    required String hayvaninkupeno,
    required String yapilacakasi,
    required String asilayankisi,
    required String asilamanot,
    required DateTime asilamabaslangic,
    required DateTime asilamabitis,
  }) async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar')
        .where("hayvaninkupeno", isEqualTo: _hayvankupenocontroller.text);
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          HayvanEkleFirebase hayvan = HayvanEkleFirebase.fromJson(hayvanMap);
          String hayvanId = hayvan.hayvanId;
          final docUser = FirebaseFirestore.instance
              .collection('kullanicilar')
              .doc(_auth.currentUser!.uid)
              .collection('hayvanlar')
              .doc(hayvanId)
              .collection('asilama')
              .doc();
          final hastalik = AsilamaEkleFirebase(
              asilamanot: asilamanot,
              asilayankisiismi: asilayankisi,
              hayvanId: hayvanId,
              asilamaId: docUser.id,
              hayvaninkupeno: hayvaninkupeno,
              yapilanasiismi: yapilacakasi,
              asilamabaslangic: asilamabaslangic,
              asilamabitis: asilamabitis);
          await docUser.set(hastalik.toJson());
        }
      }
    }
  }

  void textFieldKontrol() {
    if (_hayvankupenocontroller.text.isEmpty ||
        _yapilacakasicontroller.text.isEmpty ||
        _asilayankisicontroller.text.isEmpty ||
        _asibaslangiccontroller.text.isEmpty ||
        _asibitiscontroller.text.isEmpty) {
      _textfieldkontrol = false;
    } else {
      _textfieldkontrol = true;
    }
  }
}
