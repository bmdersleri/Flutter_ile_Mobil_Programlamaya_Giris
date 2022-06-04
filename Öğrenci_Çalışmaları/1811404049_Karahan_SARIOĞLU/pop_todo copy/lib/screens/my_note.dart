// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model.dart';
import 'controller.dart';

class MyNote extends StatelessWidget {
  int? index;
  MyNote({this.index});
  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.find();
    String text = "";
    text = index == null ? " " : nc.notes[index!].title;
    TextEditingController textEditingController =
        new TextEditingController(text: text);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffFFC803),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              toolbarHeight: 120,
              elevation: 0,
              backgroundColor: Color(0xffFFC803),
              title: index == null
                  ? Text(
                      'What do you need?',
                      style: TextStyle(color: Colors.black),
                    )
                  : Text("Let's update this note!",
                      style: TextStyle(color: Colors.black)),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(48, 120, 48, 48),
              child: Container(
                height: 720,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Create a new note!!',
                          hintStyle: TextStyle(color: Color(0xffFF2626)),
                          labelText: ' Well well...',
                          labelStyle: TextStyle(color: Color(0xffFF2626)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffFF2626),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        style:
                            TextStyle(fontSize: 20, color: Color(0xffFF2626)),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            hoverElevation: 0,
                            elevation: 0,
                            padding: EdgeInsets.fromLTRB(48, 24, 48, 24),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Color(0xffFF2626),
                          ),
                          RaisedButton(
                            elevation: 0,
                            hoverElevation: 0,
                            padding: EdgeInsets.fromLTRB(48, 24, 48, 24),
                            onPressed: () {
                              if (index == null) {
                                nc.notes.add(
                                    Note(title: textEditingController.text));
                              } else {
                                var updatenote = nc.notes[index!];
                                updatenote.title = textEditingController.text;
                                nc.notes[index!] = updatenote;
                              }
                              Get.back();
                            },
                            child: index == null
                                ? Text('Add',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                                : Text('Update',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                            color: Color(0XFF9B4DFF),
                          )
                        ])
                  ],
                ),
              ),
            )));
  }
}
