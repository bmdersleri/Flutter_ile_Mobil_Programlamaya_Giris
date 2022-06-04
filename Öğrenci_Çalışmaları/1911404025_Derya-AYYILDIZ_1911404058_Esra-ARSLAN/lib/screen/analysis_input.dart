import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:vetlogin/widget/list_field.dart';
import 'package:vetlogin/widget/mastitValue.dart';

class AnaliysisInput extends StatefulWidget {
  @override
  _AnaliysisInputState createState() => _AnaliysisInputState();
}

class _AnaliysisInputState extends State<AnaliysisInput> {
  final _formfarm = GlobalKey<FormState>();
  final _formanimal = GlobalKey<FormState>();
  final _formanalysis = GlobalKey<FormState>();
  
  
  String dropLobOne = "Seç";


  setDropLobOne(value) => setState(() => dropLobOne = value);
  getDropLobOne() => dropLobOne;

  String dropLobTwo = "Seç";

  setDropLobTwo(value) => setState(() => dropLobTwo = value);
  getDropLobTwo() => dropLobTwo;

  String dropLobThree = "Seç";

  setDropLobThree(value) => setState(() => dropLobThree = value);
  getDropLobThree() => dropLobThree;

  String dropLobFour = "Seç";

  setDropLobFour(value) => setState(() => dropLobFour = value);
  getDropLobFour() => dropLobFour;

  double average_data = 0;
  TextEditingController farmname = TextEditingController();
  TextEditingController animalId = TextEditingController();
  TextEditingController analysisKind = TextEditingController();

  String search_text = "";
  _search_text(value) => setState(() => search_text = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahlil Gir'),
      ),
      resizeToAvoidBottomInset: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 600,
                  height: 1000,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 45, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 222, left: 0.0, bottom: 5),
                              child: Text(
                                "Çiftlik Adı",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Form(
                              key:_formfarm,
                              child: TextFormField(
                                controller: farmname,
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen çiftlik adı giriniz';
                                } else  {
                        
                                return null;}
                              },
                              ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 222, left: 0.0, bottom: 5),
                              child: Text(
                                "Hayvan İd",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Form(
                              key:_formanimal,
                              
                              child: TextFormField(
                                controller: animalId,
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen hayvan id giriniz';
                                } else  {
                        
                                return null;}
                              },
                              ),
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 218, left: 0.0, bottom: 5),
                              child: Text(
                                "Tahlil Türü",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                             child: Form(
                              key:_formanalysis,
                              
                              child: TextFormField(
                                controller: analysisKind,
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen tahlil türü giriniz';
                                } else  {
                        
                                return null;}
                              },
                              ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListField(text: "Lob 1",
                                        list: ["Seç", "1", "2", "3", "4", "5"],
                                        setDropdownValue: setDropLobOne,
                                        getDropdownValue: getDropLobOne),
                                    // MastitValue(
                                    //   text: "1. Lob ",
                                    //   control: lobOne,
                                    // ),
                                    ListField(text: "Lob 2",
                                        list: ["Seç", "1", "2", "3", "4", "5"],
                                        setDropdownValue: setDropLobTwo,
                                        getDropdownValue: getDropLobTwo),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListField(text: "Lob 3",
                                        list: ["Seç", "1", "2", "3", "4", "5"],
                                        setDropdownValue: setDropLobThree,
                                        getDropdownValue: getDropLobThree),
                                    ListField(text: "Lob 4",
                                        list: ["Seç", "1", "2", "3", "4", "5"],
                                        setDropdownValue: setDropLobFour,
                                        getDropdownValue: getDropLobFour),
                                  ],
                                )
                              ],
                            ),
                            buildInputBtn(),
                   
                            Text( 
                              
                              average_data.toString(),
                              style: TextStyle( backgroundColor: average_data < 3
                                      ? Colors.green
                                      : Colors.red,

                                  color: Colors.white,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  func() {
    print("object");
  }

  Widget buildInputBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
          bool farmflag = false;
          bool animalflag = false;
          bool analysisflag = false;
          if (_formfarm.currentState!.validate())
            {
              farmflag = true;
            }
           else
             {print("_formfarm.currentState true");}
           if (_formanalysis.currentState!.validate()) {
             analysisflag = true;
           } else {
             print("_formUser.currentState true");
          }
          if (_formanimal.currentState!.validate()) {
             animalflag = true;
           } else {
             print("_formUser.currentState true");
          }
          if (farmflag && analysisflag && animalflag) {
          input();
          }
        },
        child: Text(
          'Hesapla',
          style: TextStyle(
            color: Color(0xff2c2772),
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // <-- Radius
          ),
        ),
      ),
    );
  }

  void input() async {
    var url = Uri.parse("http://proje.yusufboran.com/mail/mastitis-input.php");

    int value1 = dropLobOne == "Seç" ? 0 : int.parse(dropLobOne);
    int value2 = dropLobTwo == "Seç" ? 0 : int.parse(dropLobTwo);
    int value3 = dropLobThree == "Seç" ? 0 : int.parse(dropLobThree);
    int value4 = dropLobFour == "Seç" ? 0 : int.parse(dropLobFour);
    var data = {
      'farmname': farmname.text.toString(),
      'animalId': animalId.text.toString(),
      'analysisKind': analysisKind.text.toString(),
      'lobOne': value1.toString(),
      'lobTwo':  value2.toString(),
      'lobThree':  value3.toString(),
      'lobFour':  value4.toString(),
    };

    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
    } else {
      print('A network error occurred : input');
    }
    setState(() {
      average_data = (value1 + value2 + value3 + value4) / 4;
    });
    press();
  }

  void press() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kayıt Başarılı'),
      ),
    );
  }
}
