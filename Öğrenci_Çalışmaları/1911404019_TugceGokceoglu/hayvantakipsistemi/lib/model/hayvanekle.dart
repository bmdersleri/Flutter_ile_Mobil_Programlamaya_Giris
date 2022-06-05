import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hayvantakipsistemi/ililcesecmesayfasi/veriler.dart';
import 'package:hayvantakipsistemi/model/textfieldarama.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';

class HayvanEkleModal extends StatefulWidget {
  bool? hayvanekeklendi;
   HayvanEkleModal({Key? key,this.hayvanekeklendi}) : super(key: key);

  @override
  State<HayvanEkleModal> createState() => _HayvanEkleModalState();
}

FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
 final kullaniciId = _auth.currentUser!.uid;
CalendarFormat _format = CalendarFormat.month;
final _date = DateTime.now();
final _dateFormat = 'dd.MM.yyyy';
final _formattedDate = DateFormat(_dateFormat).format(_date);

bool _textfieldkontrol = false;
bool? _kupenokontrol;

class _HayvanEkleModalState extends State<HayvanEkleModal> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  File? _secilenDosya;
  bool _secilidisi = true;
  bool _secilierkek = false;
  String _cinsiyet = "Dişi";
  Veriler veri = Veriler();
  TextEditingController _dogumtarihi =
      TextEditingController(text: _formattedDate);
  TextEditingController _hayvaninirkicontroller = TextEditingController();
  TextEditingController _hayvaninkupenocontroller = TextEditingController();
  TextEditingController _anneninirkicontroller = TextEditingController();
  TextEditingController _anneninkupenocontroller = TextEditingController();
  TextEditingController _babaninirkicontroller = TextEditingController();
  TextEditingController _babaninkupenocontroller = TextEditingController();
  TextEditingController _bulunduguilcontroller = TextEditingController();
  TextEditingController _bulunduguilcecontroller = TextEditingController();
  TextEditingController _dogumturucontroller = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  /// JSON yüklenmesinin tamamlanıp tamamlanmadığı kontrolu için
  bool _yuklemeTamamlandiMi = false;

  /// Sonuç il ve ilçe
  String _secilenIl = "";
  String _secilenIlce = "";

  /// JSON'dan okuyacağımız "Il" nesnelerinin toplanacağı liste
  List<dynamic> _illerListesi = [];

  /// Il ve Ilce Secme Sayfalarına gönderirken tanımlayacağımız listeler
  List<String> _ilIsimleriListesi = [];

  List<String> _ilceIsimleriListesi = [];

  /// JSON'u okuyup içinden Il nesnelerini listede toplama
  Future<void> _illeriGetir() async {
    String jsonString = await rootBundle.loadString('assets/json/il-ilce.json');

    final jsonResponse = json.decode(jsonString);

    _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  /// Il nesnelerinden sadece il_adi değişkenlerini ayrı bir listede toplama
  void _ilIsimleriniGetir() {
    _ilIsimleriListesi = [];

    for (var element in _illerListesi) {
      _ilIsimleriListesi.add(element.ilAdi);
    }

    setState(() {
      _yuklemeTamamlandiMi = true;
    });
  }

  void _IlceGetir() {
    _ilceIsimleriListesi = [];
    for (var element in _illerListesi) {
      element.ilceler.forEach((element) {
        _ilceIsimleriListesi.add(element.ilceAdi);
      });
    }
  }

  /// Ilce seçimi için seçilen ile göre ilçeleri getirme
  void _secilenIlinIlceleriniGetir(String _secilenIl) {
    _ilceIsimleriListesi = [];
    for (var element in _illerListesi) {
      if (element.ilAdi == _secilenIl) {
        element.ilceler.forEach((element) {
          _ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
    initializeDateFormatting();
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
                    if (_kupenokontrol == true) {
                      createAnimal(
                        anneninirki: _anneninirkicontroller.text,
                        anneninkupeno: _anneninkupenocontroller.text,
                        babaninirki: _babaninirkicontroller.text,
                        babaninkupeno: _babaninkupenocontroller.text,
                        bulunduguilce: _bulunduguilcontroller.text,
                        bulunuduguil: _bulunduguilcecontroller.text,
                        dogumtarihi:
                            DateFormat(_dateFormat).parse(_dogumtarihi.text),
                        dogumturu: _dogumturucontroller.text,
                        hayvanincinsiyeti: _cinsiyet,
                        hayvaninirki: _hayvaninirkicontroller.text,
                        hayvaninkupeno: _hayvaninkupenocontroller.text,
                        secilendosya: _secilenDosya,
                      );
                      startTimer("Hayvan Eklendi!", true);
                      widget.hayvanekeklendi=true;
                    } else {
                      startTimer(
                          "Bu küpe Numarasına Ait Hayvan Bulunmaktadır", false);
                    }
                  } else {
                    startTimer("Boş Alan Bırakmayınız", false);
                  }
                },
                child: Text(
                  "Hayvan Ekle",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _secilenDosya == null
                ? GestureDetector(
                    onTap: () {
                      _secimFotoGoter(context);
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/images/art.png',
                        )),
                  )
                : CircleAvatar(
                    radius: 70, backgroundImage: FileImage(_secilenDosya!)),
            SizedBox(
              height: 15,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  _secimFotoGoter(context);
                },
                child: Text(
                  "Resim Ekle",
                  style: TextStyle(color: Color(0xFF375BA3)),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() {
                    setState(() {
                      if (_secilidisi == false) {
                        _cinsiyet = "Dişi";
                        _secilidisi = true;
                        _secilierkek = false;
                      } else {
                        _secilidisi = false;
                      }
                    });
                  }),
                  child: Row(children: [
                    FaIcon(
                      FontAwesomeIcons.venus,
                      color: _secilidisi == false
                          ? Colors.black
                          : Color(0xFF375BA3),
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Dişi",
                      style: TextStyle(
                          color: _secilidisi == false
                              ? Colors.black
                              : Color(0xFF375BA3)),
                    ),
                  ]),
                ),
                InkWell(
                  onTap: (() {
                    setState(() {
                      if (_secilierkek == false) {
                        _cinsiyet = "Erkek";
                        _secilierkek = true;
                        _secilidisi = false;
                      } else {
                        _secilierkek = false;
                      }
                    });
                  }),
                  child: Row(children: [
                    FaIcon(
                      FontAwesomeIcons.mars,
                      color: _secilierkek == false
                          ? Colors.black
                          : Color(0xFF375BA3),
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Erkek",
                        style: TextStyle(
                            color: _secilierkek == false
                                ? Colors.black
                                : Color(0xFF375BA3))),
                  ]),
                ),
              ],
            ),
            //Hayvanın Küpe Numarası Textfield
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
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  onChanged: (context) => kupeNoSorgula(),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  controller: _hayvaninkupenocontroller,
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
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _hayvaninirkicontroller,
                      inputType: TextInputType.text,
                      hinttext: "Hayvanın Irkını Seçiniz...",
                      items: veri.irk,
                      selectedItem: _hayvaninirkicontroller.text,
                      onSelection: (v) {
                        _hayvaninirkicontroller.text = v;
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
                    controller: _hayvaninirkicontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: " Hayvanın Irkını Seçiniz",
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
            //Annenin Küpe Numarası Textfield
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
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  controller: _anneninkupenocontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Annenin Küpe Numarası",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _anneninirkicontroller,
                      inputType: TextInputType.text,
                      hinttext: "Annenin Irkını Seçiniz...",
                      items: veri.irk,
                      selectedItem: _anneninirkicontroller.text,
                      onSelection: (v) {
                        _anneninirkicontroller.text = v;
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
                    controller: _anneninirkicontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: " Annenin Irkını Seçiniz",
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
            //Babanın Küpe Numarası Textfield
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
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  controller: _babaninkupenocontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Babanın Küpe Numarası",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _babaninirkicontroller,
                      inputType: TextInputType.text,
                      hinttext: "Babanın Irkını Seçiniz...",
                      items: veri.irk,
                      selectedItem: _babaninirkicontroller.text,
                      onSelection: (v) {
                        _babaninirkicontroller.text = v;
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
                    controller: _babaninirkicontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: " Babanın Irkını Seçiniz",
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

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _bulunduguilcontroller,
                      inputType: TextInputType.text,
                      hinttext: "Bulunduğu İli Seçiniz...",
                      items: _ilIsimleriListesi,
                      selectedItem: _bulunduguilcecontroller.text,
                      onSelection: (v) {
                        _secilenIl = v;
                        _bulunduguilcontroller.text = _secilenIl;
                        setState(() {
                          _secilenIlinIlceleriniGetir(_secilenIl);
                        });
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
                    controller: TextEditingController(text: _secilenIl),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Bulunduğu İli Seçiniz",
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _bulunduguilcecontroller,
                      inputType: TextInputType.text,
                      hinttext: "Bulunduğu İlçeyi Seçiniz...",
                      items: _ilceIsimleriListesi,
                      selectedItem: _bulunduguilcontroller.text,
                      onSelection: (v) {
                        _bulunduguilcecontroller.text =v;
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
                    controller: _bulunduguilcecontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Bulunduğu İlçeyi Seçiniz",
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
            //Doğum tarihi
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
                inputFormatters: [maskFormatter],
                keyboardType: TextInputType.number,
                controller: _dogumtarihi,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xFF375BA3),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Scaffold(
                                  body: TableCalendar(
                                    locale: 'tr_TR',
                                    focusedDay: _focusedDay,
                                    firstDay: DateTime(1990),
                                    lastDay: DateTime.now()
                                        .subtract(Duration(days: 0)),
                                    calendarFormat: _format,
                                    onFormatChanged: (CalendarFormat _format) {
                                      setState(() {
                                        _format =
                                            _format; // Bugünün Tarihini Seçtirdik.
                                      });
                                    },
                                    calendarStyle: CalendarStyle(
                                        todayDecoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 123, 203, 198),
                                          shape: BoxShape.circle,
                                        ),
                                        isTodayHighlighted: true,
                                        selectedDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF375BA3),
                                              Color(0xFF29E3D7)
                                            ],
                                            begin: FractionalOffset.centerLeft,
                                            end: FractionalOffset.centerRight,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        selectedTextStyle:
                                            TextStyle(color: Colors.white)),
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekendStyle:
                                          TextStyle(color: Colors.black),
                                      weekdayStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: true,
                                      titleCentered: true,
                                      formatButtonShowsNext: false,
                                      formatButtonDecoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Color(0xFF375BA3)),
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                    ),
                                    selectedDayPredicate: (DateTime date) {
                                      return isSameDay(_selectedDay, date);
                                    },
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    daysOfWeekVisible: true,
                                    onDaySelected: (DateTime selectDay,
                                        DateTime focusDay) {
                                      setState(() {
                                        _selectedDay = selectDay;
                                        _focusedDay = focusDay;
                                        _dogumtarihi.text =
                                            DateFormat(_dateFormat)
                                                .format(selectDay);
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                      }),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Doğum Tarihi',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchSelectPage(
                      controller: _dogumturucontroller,
                      inputType: TextInputType.text,
                      hinttext: "Doğum Türünü Seçiniz...",
                      items: veri.dogum,
                      selectedItem: _dogumturucontroller.text,
                      onSelection: (v) {
                        _dogumturucontroller.text = v;
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 16, bottom: 30),
                padding: EdgeInsets.only(left: 16),
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
                  enabled: false,
                  controller: _dogumturucontroller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Doğum Türü",
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
          ],
        ),
      ),
    );
  }

  void textFieldKontrol() {
    if (_hayvaninkupenocontroller.text.isEmpty ||
        _hayvaninirkicontroller.text.isEmpty ||
        _anneninirkicontroller.text.isEmpty ||
        _anneninkupenocontroller.text.isEmpty ||
        _babaninirkicontroller.text.isEmpty ||
        _babaninkupenocontroller.text.isEmpty ||
        _bulunduguilcecontroller.text.isEmpty ||
        _bulunduguilcontroller.text.isEmpty ||
        _dogumturucontroller.text.isEmpty) {
      _textfieldkontrol = false;
    } else {
      _textfieldkontrol = true;
    }
  }

  void _secimFotoGoter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            title: Text("Galeriden Fotoğraf Seç"),
            onTap: () {
              _secimYukle(ImageSource.gallery);
            },
          ),
          ListTile(
            title: Text("Kameradan Fotoğraf Seç"),
            onTap: () {
              _secimYukle(ImageSource.camera);
            },
          ),
        ]),
      ),
    );
  }

  void _secimYukle(ImageSource source) async {
    final picker = ImagePicker();
    final secilen = await picker.pickImage(source: source);
    setState(() {
      if (secilen != null) {
        _secilenDosya = File(secilen.path);
      }
    });
    Navigator.pop(context);
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

  void kupeNoSorgula() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
      .collection('kullanicilar').doc(kullaniciId)
        .collection('hayvanlar')
        .where("hayvaninkupeno", isEqualTo: _hayvaninkupenocontroller.text);
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
      _kupenokontrol = false;
    } else {
      _kupenokontrol = true;
    }
  }
  
}

Future createAnimal({
  File? secilendosya,
  required String hayvanincinsiyeti,
  required String hayvaninkupeno,
  required String hayvaninirki,
  required String anneninirki,
  required String anneninkupeno,
  required String babaninirki,
  required String babaninkupeno,
  required String bulunuduguil,
  required String bulunduguilce,
  required DateTime dogumtarihi,
  required String dogumturu,
}) async {
 
  final dochayvan = FirebaseFirestore.instance.collection('kullanicilar').doc(kullaniciId).collection('hayvanlar').doc();
  String dosyaIsmi = dochayvan.id;
  if (secilendosya != null) {
    File file = File(secilendosya.path);
    final hayvan = HayvanEkleFirebase(
        kullaniciId: kullaniciId,
        hayvanId: dosyaIsmi,
        hayvanincinsiyeti: hayvanincinsiyeti,
        hayvaninkupeno: hayvaninkupeno,
        hayvaninirki: hayvaninirki,
        anneninkupeno: anneninkupeno,
        anneninirki: anneninirki,
        babaninkupeno: babaninkupeno,
        babaninirki: babaninirki,
        bulunuduguil: bulunuduguil,
        bulunduguilce: bulunduguilce,
        dogumtarihi: dogumtarihi,
        dogumturu: dogumturu);
    TaskSnapshot yukleme = await _storage
        .ref('hayvanlar/$kullaniciId/$dosyaIsmi.jpg')
        .putFile(file);
    String dosyaBaglantisi = await yukleme.ref.getDownloadURL();
    hayvan.resim = dosyaBaglantisi;
    await dochayvan.set(hayvan.toJson());
  } else {
    final hayvan = HayvanEkleFirebase(
        kullaniciId: kullaniciId,
        hayvanId: dosyaIsmi,
        hayvanincinsiyeti: hayvanincinsiyeti,
        hayvaninkupeno: hayvaninkupeno,
        hayvaninirki: hayvaninirki,
        anneninkupeno: anneninkupeno,
        anneninirki: anneninirki,
        babaninkupeno: babaninkupeno,
        babaninirki: babaninirki,
        bulunuduguil: bulunuduguil,
        bulunduguilce: bulunduguilce,
        dogumtarihi: dogumtarihi,
        dogumturu: dogumturu);
    await dochayvan.set(hayvan.toJson());
  } 
}
