import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sut_cepte_mobile_app/model/maliyet_tip.dart';
import 'package:sut_cepte_mobile_app/providers/maliyet_listeleme.dart';
import 'package:sut_cepte_mobile_app/screens/drawer.dart';
import 'package:sut_cepte_mobile_app/screens/malitet_list.dart';

class MaliyetHesapla extends StatefulWidget {
  const MaliyetHesapla({Key? key}) : super(key: key);

  @override
  State<MaliyetHesapla> createState() => _MaliyetHesaplaState();
}

class _MaliyetHesaplaState extends State<MaliyetHesapla> {
  String selectedValue = "Rasyon";
  late MalitetListelePoriver _malitetListelePoriver;
  var _formState = GlobalKey<FormState>();
  String? selectedName;
  String? selectedDeger;
  String? selectedKg;
  @override
  Widget build(BuildContext context) {
    _malitetListelePoriver = Provider.of<MalitetListelePoriver>(context);
    return Scaffold(
      backgroundColor: Colors.indigo,
      drawer: Drawer(child: DrawerMe()),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Hesaplama",
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 30),
              maliyetListeDownMetot(),
              hesaplamaMetotu(),
              const SizedBox(
                width: 10,
              ),
              ekleButonuMetot(),
              MalitetList(onDismissed: (index) {
                _malitetListelePoriver.listRemove(index);
              }),
              SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Container ekleButonuMetot() {
    return Container(
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.black),
          onPressed: () {
            if (_formState.currentState!.validate()) {
              _formState.currentState!.save();

              MaliyetModel model = MaliyetModel();
              model.maliyetName = selectedName;
              model.maliyerDeger = selectedDeger;
              model.maliyetTipi = selectedValue;
              if (selectedValue == "Rasyon") {
                model.kg = selectedKg!;
              }

              _malitetListelePoriver.addItem(model);
            }
          },
          child: Text(
            "Ekle",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontSize: 18,
            )),
          )),
    );
  }

  Padding maliyetListeDownMetot() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Colors.white,
            filled: true),
        onChanged: ((value) {
          setState(() {
            selectedValue = value.toString();
          });
        }),
        value: selectedValue,
        items: [
          DropdownMenuItem(
            child: Text(
              "Rasyon",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            value: "Rasyon",
          ),
          DropdownMenuItem(
            child: Text(
              "Gelirler",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            value: "Gelirler",
          ),
          DropdownMenuItem(
            child: Text(
              "Giderler",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            value: "Giderler",
          ),
        ],
      ),
    );
  }

  Form hesaplamaMetotu() => Form(
        key: _formState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: textFormFieldMy(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: textFormFieldDeger(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: textFormFieldKG(),
            ),
          ],
        ),
      );

  TextFormField textFormFieldMy() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          selectedName = newValue;
        });
      },
      decoration: InputDecoration(
          hintText: selectedValue == "Rasyon"
              ? "Yem Adı"
              : selectedValue == "Gelirler"
                  ? "Gelir Adı"
                  : selectedValue == "Giderler"
                      ? "Gider Adı"
                      : "",
          hintStyle: GoogleFonts.poppins(),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }

  Widget textFormFieldKG() {
    return Visibility(
      visible: selectedValue == "Rasyon" ? true : false,
      child: TextFormField(
        onSaved: (newValue) {
          setState(() {
            selectedKg = newValue;
          });
        },
        decoration: InputDecoration(
            hintText: "Kilo",
            hintStyle: GoogleFonts.poppins(),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }

  TextFormField textFormFieldDeger() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          selectedDeger = newValue;
        });
      },
      decoration: InputDecoration(
          hintText: selectedValue == "Rasyon"
              ? "Yem Birim Fiyatı (TL)"
              : selectedValue == "Gelirler"
                  ? "Gelir Deger (TL)"
                  : selectedValue == "Giderler"
                      ? "Gider Deger (TL)"
                      : "",
          hintStyle: GoogleFonts.poppins(),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
