import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vs_code_gelirgider_takip/expenses_incomes.dart';
import 'package:vs_code_gelirgider_takip/under_appbar.dart';
import 'islem.dart';
import 'islem_manager.dart';
import 'my_appbar.dart';

//ignore_for_file: prefer_const_constructors

class InputPage extends StatefulWidget {
  const InputPage({Key? key,}) : super(key: key);

  static final Color primaryColor = Colors.deepOrangeAccent.shade200;
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _textcontrollerFiyat = TextEditingController();
  final _textcontrollerIslem = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isGelir = false;

  // enter the new transactiont

  void _yeniIslem() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: InputPage.primaryColor,
                title: Center(child: Text('N E W  T R A N S A C T I O N')),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isGelir,
                            onChanged: (newValue) {
                              setState(() {
                                _isGelir = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Price?',
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter valid price!';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerFiyat,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For What?',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              controller: _textcontrollerIslem,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Back', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Okey', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final islemAdi = _textcontrollerIslem.text;
                        final islemFiyati =
                            double.parse(_textcontrollerFiyat.text);
                        final islemTuru;

                        final islem = Islem(
                            userId: user.uid,
                            islemAdi: islemAdi,
                            islemFiyati: islemFiyati,
                            islemTuru: _isGelir == true
                                ? islemTuru = 'gelir'
                                : islemTuru = 'gider');

                        IslemManager().createIslem(islem);
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.grey.shade300,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(50), child: MyAppBar()),
      body: Column(
        children: [
          Expanded(flex: 2, child: UnderAppBar(context: context)),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: StreamBuilder<List<Islem>>(
                      stream: IslemManager().readIslemler(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Bir şeyler yanlış gitti ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final islemler = snapshot.data!;
                          return ListView(
                            children: islemler.map(buildIslemler).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _yeniIslem();
        },
        backgroundColor: InputPage.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildIslemler(Islem islem) {
    if ( user.uid == islem.userId) {
      return ExpensesIncomes(
        gelirVeyaGider: islem.islemTuru,
        islemAdi: islem.islemAdi,
        para: islem.islemFiyati.toString(),
      );
    } else
      return SizedBox(
        height: 0,
      );
  }
}
