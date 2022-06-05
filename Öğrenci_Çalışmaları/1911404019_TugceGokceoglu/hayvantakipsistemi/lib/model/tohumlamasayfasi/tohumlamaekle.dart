import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/notlar/tohumlama.dart';
import 'package:hayvantakipsistemi/model/takvimicon.dart';
import 'package:hayvantakipsistemi/model/textfieldarama.dart';
import 'package:hayvantakipsistemi/model/tohumlamasayfasi/refreshTohumlama.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';
import 'package:hayvantakipsistemi/view/tohumlamasayfasi.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TohumalamaEkleModal extends StatefulWidget {
  bool sayfayonlendir;
  TohumalamaEkleModal({Key? key, required this.sayfayonlendir})
      : super(key: key);

  @override
  State<TohumalamaEkleModal> createState() => _TohumalamaEkleModalState();
}

bool _textfieldkontrol = false;
FirebaseAuth _auth = FirebaseAuth.instance;
Veriler veri = Veriler();
final _dateFormat = 'dd.MM.yyyy';
CalendarFormat format = CalendarFormat.month;
final _formattedDate = DateFormat(_dateFormat).format(DateTime.now());
DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();
TextEditingController _hayvankupenocontroller = TextEditingController();
TextEditingController _boganinkupenocontroller = TextEditingController();
TextEditingController _boganinirkicontroller = TextEditingController();
TextEditingController _tohumlamayiyapanvetcontroller = TextEditingController();
TextEditingController _tohumlamabaslangicontroller =
    TextEditingController(text: _formattedDate);
TextEditingController _tohumlamabitiscontroller =
    TextEditingController(text: _formattedDate);
TextEditingController _tohumlamanotcontroller = TextEditingController();

class _TohumalamaEkleModalState extends State<TohumalamaEkleModal> {
  List<String> _hayvanlarkupeno = [];
  List<String> _hayvanIdleri = [];
  @override
  initState() {
    _hayvanlarkupeno = [];
    _hayvanIdleri = [];
    _readTumHayvanlar();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  _textFieldKontrol();
                  if (_textfieldkontrol == true) {
                    _createTohumlama(
                      hayvaninkupeno: _hayvankupenocontroller.text,
                      boganinkupeno: _boganinkupenocontroller.text,
                      boganinirki: _boganinirkicontroller.text,
                      tohumlamayiyapanvet: _tohumlamayiyapanvetcontroller.text,
                      tohumlamanot: _tohumlamanotcontroller.text,
                      tohumlamabaslangic: DateFormat(_dateFormat)
                          .parse(_tohumlamabaslangicontroller.text),
                      tohumlamabitis: DateFormat(_dateFormat)
                          .parse(_tohumlamabitiscontroller.text),
                    );

                    if (widget.sayfayonlendir == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TohumlamaSayfasi()),
                      ).then((res) => RefreshTohumlama());
                    } else {
                      Navigator.pop(context);
                    }
                  } else {
                    startTimer("Boş Alan Bırakmayınız", false);
                  }
                },
                child: Text(
                  "Tohumlamayı Ekle",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ))),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchSelectPage(
                    controller: _hayvankupenocontroller,
                    inputType: TextInputType.number,
                    hinttext: " Tohumlanan Hayvanın Küpe Numarasını Seçiniz...",
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
                    hintText: "Tohumlanan Hayvanın Küpe Numarası",
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
              controller: _boganinkupenocontroller,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Boğanın Küpe Numarası",
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchSelectPage(
                    controller: _boganinirkicontroller,
                    inputType: TextInputType.text,
                    hinttext: "Boğanın Irkını Seçiniz...",
                    items: veri.irk,
                    selectedItem: _boganinirkicontroller.text,
                    onSelection: (v) {
                      _boganinirkicontroller.text = v;
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
                  controller: _boganinirkicontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Boğanın Irkını Seçiniz",
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
          //Tohumlama Yapan Veteriner Textfield
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
              controller: _tohumlamayiyapanvetcontroller,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Tohumlamayı Yapan Veteriner",
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
          //tohumlama başlangıç tarihi
          TakvimIcon(
              controller: _tohumlamabaslangicontroller,
              focusedDay: DateTime.now(),
              selectedDay: DateTime.now(),
              labeltext: "Tohumlama Başlangıç Tarihi"),
          SizedBox(
            height: 8,
          ),
          TakvimIcon(
              labeltext: "Tohumlama Bitiş Tarihi",
              controller: _tohumlamabitiscontroller,
              focusedDay: focusedDay,
              selectedDay: selectedDay),
          SizedBox(
            height: 8,
          ),
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
                controller: _tohumlamanotcontroller,
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

  Future<List<dynamic>> _readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar');

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

  void _textFieldKontrol() {
    if (_hayvankupenocontroller.text.isEmpty ||
        _boganinkupenocontroller.text.isEmpty ||
        _boganinirkicontroller.text.isEmpty ||
        _tohumlamabaslangicontroller.text.isEmpty ||
        _tohumlamabitiscontroller.text.isEmpty ||
        _tohumlamayiyapanvetcontroller.text.isEmpty) {
      _textfieldkontrol = false;
    } else {
      _textfieldkontrol = true;
    }
  }

  Timer? _timer;
  void startTimer(String hinttext, bool deger) {
    int _start = 50;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 && deger == true) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 0 && deger == false) {
          setState(() {
            timer.cancel();
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
                      height: 40,
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
                          child: Wrap(
                            children: [
                              Text(
                                hinttext,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "lucida",
                                  fontSize: 12,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
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
            _start--;
          });
        }
      },
    );
  }

  Future _createTohumlama({
    required String hayvaninkupeno,
    required String boganinkupeno,
    required String boganinirki,
    required String tohumlamayiyapanvet,
    required String tohumlamanot,
    required DateTime tohumlamabaslangic,
    required DateTime tohumlamabitis,
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
              .collection('tohumlama')
              .doc();
          final tohumlama = TohumlamaEkleFirebase(
              boganinkupeno: boganinkupeno,
              tohumlamayiyapanvet: tohumlamayiyapanvet,
              tohumlamanot: tohumlamanot,
              hayvanId: hayvanId,
              tohumlamaId: docUser.id,
              hayvaninkupeno: hayvaninkupeno,
              boganinirki: boganinirki,
              tohumlamabaslangic: tohumlamabaslangic,
              tohumlamabitis: tohumlamabitis);
          await docUser.set(tohumlama.toJson());
        }
      }
    }
  }
}
