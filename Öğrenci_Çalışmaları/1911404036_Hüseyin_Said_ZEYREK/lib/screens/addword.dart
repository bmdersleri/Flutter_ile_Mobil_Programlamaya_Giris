import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_dictionary/main.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({ Key? key }) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {

  final controllerFirstWord = TextEditingController();
  final controllerSecondWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelime Ekleme Ekrani"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30),
            child: TextField(
              controller: controllerFirstWord,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'İlk Kelimeyi Giriniz',
              ),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 40),
            child: TextField(
              controller: controllerSecondWord,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'İkinci Kelimeyi Giriniz',
              ),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(30),
            color: Colors.amber,
            child: Text("Kelimeleri Kaydet", style: TextStyle(
              fontSize: 20,
            ),),
            onPressed: (){
              final word = Word(firstword: controllerFirstWord.text, secondword: controllerSecondWord.text);
              createWord(word);
              Navigator.pop(context);
            }
          )          
        ],
      ),
    );
  }

  Future createWord(Word word) async{
    final docWord = FirebaseFirestore.instance.collection('words').doc();
    word.id = docWord.id;

    final json = word.toJson();
    await docWord.set(json);
  }
}

